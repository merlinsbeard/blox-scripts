#!/bin/bash
if [ $EUID != 0];
then
    echo "Must run as sudo"
    exit
else
    echo "running as sudo"
fi

echo "Now checking if blox.conf exists"
if [ ! -f /etc/init/blox.conf ];
then
    echo "Copying blox.conf"
    cp blox.conf /etc/init/
fi

echo "Now Downloading blox user homepage"
git clone https://github.com/merlinsbeard/blox-user-homepage.git
echo "Moving blox-user-homepage.git"
mkdir /var/www/html/blox
mv blox-user-homepage /var/www/html/blox/
echo "changing mod of blox-user-homepage to blox and 775"
cd /var/www/html/blox/
echo "current directory" && pwd
cp blox-user-homepage/skeleton_config.txt blox-user-homepage/config.txt

chown -R blox:blox /var/www/html/blox
chmod -R 775 /var/www/html/blox

echo "Installing python dependecies before making virtualenv"
apt-get install python-dev python-setuptools
apt-get install libtiff4-dev libjpeg8-dev zlib1g-dev \
        libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

virtualenv venv
source venv/bin/activate
pip install -r blox-user-homepage/requirements.txt


cd blox-user-homepage/static/uploads
rm Pictures
ln -s /home/blox/Pictures Pictures


# add script to change the ip in website
sudo cp ip_address_auto /etc/network/if-down.d/ip_address_auto
cd /etc/network
cd if-post-down.d
sudo ln -s ../if-down.d/ip_address_auto ip_address_auto
cd /etc/network/if-up.d
sudo ln -s ../if-down.d/ip_address_auto ip_address_auto

# Restart service to change ip in web user page
service network-manager restart

# Start the blox-user-homepage server
cd /var/www/html/blox/blox-user-homepage
./start.sh
