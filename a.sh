#!/bin/bash

# install squid
cd
apt -y install squid3
wget -O /etc/squid/squid.conf "raw.githubusercontent.com/Arya-Blitar22/vps/main/ssh/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf