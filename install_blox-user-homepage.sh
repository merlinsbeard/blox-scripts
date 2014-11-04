#!/bin/bash
# Run this script as sudo
if [ $EUID != 0]
then
    echo "Must run as sudo"
    exit
else
    echo "running as sudo"
fi

echo "Now Downloading blox user homepage"
git clone https://github.com/merlinsbeard/blox-user-homepage.git
echo "Moving blox-user-homepage.git"
mv blox-user-homepage /var/www/html/blox
echo "changing mod of blox-user-homepage to blox and 775"
cd /var/www/html/blox/
echo "current directory" && pwd
cp blox-user-homepage/skeleton_config.txt blox-user-homepage/config.txt
chmod -R 775 blox-user-homepage

chown -R blox:blox blox-user-homepage

virtualenv venv
source venv/bin/activate
pip install -r blox-user-homepage/requirements.txt


