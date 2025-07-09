#!/bin/bash
#
# ==================================================

# etc
apt dist-upgrade -y
apt install netfilter-persistent -y
apt-get remove --purge ufw firewalld -y
apt install -y screen curl jq bzip2 gzip vnstat coreutils rsyslog iftop zip unzip git apt-transport-https build-essential -y

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=ID
state=Indonesia
locality=Jakarta
organization=none
organizationalunit=none
commonname=none
email=none

# setting port ssh
cd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 40000' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 22' /etc/ssh/sshd_config
/etc/init.d/ssh restart

echo "=== Install Dropbear ==="
# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=149/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/ssh restart
/etc/init.d/dropbear restart

# // install squid for debian 9,10 & ubuntu 20.04
# install squid for debian 11
apt -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/kipas77pro/vip/refs/heads/main/SYSTEM/proxy3.js"
sed -i $MYIP2 /etc/squid/squid.conf

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
NET=$(ip -o -4 route show to default | awk '{print $5}') && \
sudo apt install -y vnstat && \
sudo vnstat --addinterface $NET && \
sudo sed -i "s/eth0/$NET/g" /etc/vnstat.conf && \
sudo systemctl enable --now vnstat

cd
# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 8880
connect = 127.0.0.1:22

[dropbear]
accept = 8443
connect = 127.0.0.1:109

[ws-stunnel]
accept = 444
connect = 700

[openvpn]
accept = 990
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart


cd
echo -e "${GREEN}    Mengkonfigurasi Dropbear...${NC}"
sudo sed -i '/^DROPBEAR_PORT=/d' /etc/default/dropbear
sudo sed -i '/^DROPBEAR_EXTRA_ARGS=/d' /etc/default/dropbear
echo 'DROPBEAR_PORT=149' | sudo tee -a /etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69 -b /etc/issue.net"' | sudo tee -a /etc/default/dropbear

sudo mkdir -p /etc/dropbear/
sudo dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
sudo dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
sudo chmod 600 /etc/dropbear/dropbear_dss_host_key
sudo chmod 600 /etc/dropbear/dropbear_rsa_host_key
sudo chown root:root /etc/dropbear/dropbear_dss_host_key
sudo chown root:root /etc/dropbear/dropbear_rsa_host_key
sudo systemctl daemon-reload
sudo systemctl restart dropbear
sudo systemctl enable nginx
clear

# remove unnecessary files
apt autoclean -y >/dev/null 2>&1
apt -y remove --purge unscd >/dev/null 2>&1
apt-get -y --purge remove samba* >/dev/null 2>&1
apt-get -y --purge remove apache2* >/dev/null 2>&1
apt-get -y --purge remove bind9* >/dev/null 2>&1
apt-get -y remove sendmail* >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
# finishing
cd

rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh0.sh
rm -f /root/bbr.sh
rm -rf /etc/apache2

clear
