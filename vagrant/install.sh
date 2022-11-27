#!/usr/bin/env bash

APPNAME=zettacode
REPOURL=https://github.com/dvarrui/$APPNAME

apt update
apt install -y vim tree nmap
apt install -y neofetch

echo "[INFO] Install ruby and $APPNAME gem"
apt install -y ruby irb
gem install $APPNAME

echo "[INFO] Download repo"
apt install -y git
git clone $REPOURL
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
