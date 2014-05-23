#!/bin/bash
sudo apt-get install mpd ncmpcpp cantata
sudo cp mpd.conf2 /etc/mpd.conf
sudo killall mpd
sudo service mpd stop
sudo service mpd start
