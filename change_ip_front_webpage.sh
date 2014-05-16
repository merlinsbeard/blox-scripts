#!/bin/bash
# THis script is used to manually change the ip for index.html of blox
# This can also automate itr


cd /var/www/html 
echo "Now Checking Wlan and ETH0"
wlan=$(ip addr | awk '/inet/ && /wlan0/{sub(/\/.*$/,"",$2); print $2}')
print "wlan: "$wlan
eth=$(ip addr | awk '/inet/ && /eth0/{sub(/\/.*$/,"",$2); print $2}')
print "eth0: "$eth

rx='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
if [[ $wlan =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
	echo "valid WLAN: "$wlan
else
	wlan="0.0.0.0"	
	echo "No Wlan detected using: "$wlan
fi

if [[ $eth =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
	echo "valid ETH0: "$eth
else
	eth='0.0.0.0'
	echo "No eth0 detected using: "$eth
fi

echo "wlan: "$wlan
echo "eth: "$eth

echo "manual or auto?"
read option

if [ $option = "manual" ]; then
    echo "Please input your new IP"
    read ip
    echo "You have input"
    echo $ip

    if [[ $ip =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
        echo "valid:     "$ip
        sudo sed -i 's/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$ip"'/g' index.html
        sudo sed -i 's/<span class=\"eth0\">[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/<span class=\"eth0\">'"$eth"'/g' index.html
        sudo sed -i 's/<span class=\"wlan0\">[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/<span class=\"wlan0\">'"$wlan"'/g' index.html
        
        echo 'Now inserting ip address to config.php'
        echo 'Adding wlan ip address'$wlan
        sleep 1s
        sudo sed -i '14s/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$wlan"'/g' /var/www/html/owncloud/config/config.php
        echo 'Adding eth '$eth
        sleep 1s
        sudo sed -i '15s/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$eth"'/g' /var/www/html/owncloud/config/config.php

        echo 'Successfully added ip of eth and wlan for config.php'

        #sudo cp index.html /var/www/html/index.html
        #sudo chmod 755 /var/www/html/index.html

        echo "Successfully Updated IP for webpage"

        sleep 3
    else
        echo "not valid: "$ip
        sleep 3
    fi
else
    echo "Proceeding with auto change of IP"

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

    echo "Now copying index.html"
    #sudo cp index.html /var/www/html/index.html
    #sudo chmod 755 /var/www/html/index.html

    echo "Successfully Updated IP for webpage"
    echo 'Now inserting ip address to config.php'
    echo 'Adding wlan ip address'$wlan
    sleep 1s
    sudo sed -i '14s/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$wlan"'/g' /var/www/html/owncloud/config/config.php
    echo 'Adding eth '$eth
    sleep 1s
    sudo sed -i '15s/[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/'"$eth"'/g' /var/www/html/owncloud/config/config.php

    echo 'Successfully added ip of eth and wlan for config.php'


    sleep 3

fi


