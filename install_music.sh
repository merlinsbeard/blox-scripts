#!/bin/bash
sudo apt-get install mpd ncmpcpp cantata
#sudo cp mpd.conf2 /etc/mpd.conf
cp mpdconf ~/.mpdconf
sudo killall mpd
sudo service mpd stop
sudo update-rc.d mpd disable
mpd
