#!/bin/bash
# Installs and configures samba
sudo apt-get install samba
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.original
sudo cp smb.conf /etc/samba/smb.conf
sudo mkdir -p /srv/samba/share
sudo chown nobody:nogroup /srv/samba/share
sudo mkdir -p /srv/{Music,Videos}
sudo chown nobody:nogroup /srv/{Music,Videos}
sudo service smbd restart
sudo service nmbd restart
