#!/bin/bash
# This script adds the ip_address_auto script to network scripts

sudo cp ip_address_auto.sh /etc/network/if-down.d/ip_address_auto
cd /etc/network
cd if-post-down.d
sudo ln -s ../if-down.d/ip_address_auto ip_address_auto
cd /etc/network/if-up.d
sudo ln -s ../if-down.d/ip_address_auto ip_address_auto

