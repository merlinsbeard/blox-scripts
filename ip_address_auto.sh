#!/bin/bash
# This Script changes the IP address of index.html according to eth or wlan
# Sometimes eth0 does not function so change eth0 to eth1 or depending on 
# the configuration
# Wlan is always a priority

cd /var/www/html/blox 
echo "Now Checking Wlan and ETH0"
wlan=$(ip addr | awk '/inet/ && /wlan0/{sub(/\/.*$/,"",$2); print $2}')
print "wlan: "$wlan
eth=$(ip addr | awk '/inet/ && /eth0/{sub(/\/.*$/,"",$2); print $2}')
print "eth0: "$eth

# Checks if ip of wlan is valid
rx='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
if [[ $wlan =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
	echo "valid WLAN: "$wlan
else
	wlan="0.0.0.0"	
	echo "No Wlan detected using: "$wlan
fi

# Checks if ip of eth is valid
if [[ $eth =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
	echo "valid ETH0: "$eth
else
	eth='0.0.0.0'
	echo "No eth0 detected using: "$eth
fi

echo "wlan: "$wlan
echo "eth: "$eth


echo "Proceeding with auto change of IP"

# will use ip of eth if wlan is no present
if [ $wlan = "0.0.0.0" ]; then
    echo "No wlan using lan for ip address" $eth
    sudo sed -i 's/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$eth"'/g' index.html    
    echo "Successfully used LAN ip address"
else
    echo "Using wlan" $wlan
    sudo sed -i 's/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$wlan"'/g' index.html    
    echo "Successfully used WLAN"
fi

sudo sed -i 's/<span class=\"eth0\">[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/<span class=\"eth0\">'"$eth"'/g' index.html
sudo sed -i 's/<span class=\"wlan0\">[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/<span class=\"wlan0\">'"$wlan"'/g' index.html

#echo "Now copying index.html"
#sudo cp index.html /var/www/html/index.html
#sudo chmod 755 /var/www/html/index.html

echo "Successfully Updated IP for webpage"
echo 'Now inserting ip address to config.php'
echo 'Adding wlan ip address'$wlan

# Adds ip of wlan and eth to owncloud config
# Enables the use of ip to be used to access owncloud
sudo sed -i '14s/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$wlan"'/g' /var/www/html/owncloud/config/config.php
echo 'Adding eth '$eth
sudo sed -i '15s/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$eth"'/g' /var/www/html/owncloud/config/config.php

echo 'Successfully added ip of eth and wlan for config.php'





