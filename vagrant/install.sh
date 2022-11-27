#!/usr/bin/env bash

APPNAME=zettacode
REPO_URL=https://github.com/dvarrui/$APPNAME

apt update
apt install -y vim tree nmap
apt install -y neofetch

echo "[INFO] Install ruby and $APPNAME"
apt install -y ruby irb
gem install $APP_NAME

echo "[INFO] Download $APPNAME"
apt install -y git
git clone $REPO_URL
chown -R vagrant:vagrant $APPNAME

echo "[INFO] Configure motd"
apt install -y figlet
figlet $APPNAME > /etc/motd
echo "" >> /etc/motd

echo "[INFO] Configure aliases"
echo "# Adding more alias" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc
echo "alias v='vdir'" >> /home/vagrant/.bashrc

lsb_release -d
