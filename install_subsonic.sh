#!/bin/bash

# This scripts installs subsonic
# subsonic is a music streaming server
# This script removes old java and replaces them with oracle's java
# 

if [ $EUID != 0];
then
    echo "Must run as sudo"
    exit
else
    echo "running as sudo"
fi

add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java7-installer

service subsonic restart
