#!/bin/bash
# Run this script as sudo
if [ $EUID != 0]
then
    echo "Must run as sudo"
    exit
else
    echo "running as sudo"
fi

echo "Now checking if blox.conf exists"
if [! -f /etc/init/blox.conf ]
then
    echo "Copying blox.conf"
    cp blox.conf /etc/init/
fi

echo "Now Downloading blox user homepage"
git clone https://github.com/merlinsbeard/blox-user-homepage.git
echo "Moving blox-user-homepage.git"
mv blox-user-homepage /var/www/html/blox
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

service network-manager restart

cd blox-user-homepage/
./start.sh
