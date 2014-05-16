# Note
# Owncloud uses apaches so we leave it as is
# Data and configs can be found in the following
# /usr/share/owncloud/
# /etc/owncloud/
# This is for ubuntu 14.04

#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list"
#sudo apt-get update
#sudo apt-get install owncloud
sudo apt-get install apache2 postgresql php5 libapache2-mod-php5
sudo apt-get install php5-gd php5-json php5-mysql php5-curl
sudo apt-get install php5-intl php5-mcrypt php5-imagick

sudo cp owncloud /var/www/html/ -R
sudo chown www-data:www-data -R /var/www/html/owncloud
sudo mkdir /etc/php5/conf.d/
sudo cp pgsql.ini /etc/php5/conf.d/
