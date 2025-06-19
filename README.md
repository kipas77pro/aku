### Os 20.04
````
apt update && apt upgrade -y && update-grub && sleep 2 && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt upgrade && apt install -y bzip2 gzip coreutils screen curl unzip && wget -q https://raw.githubusercontent.com/kipas77pro/aku/main/setup.sh && chmod +x setup.sh && ./setup.sh
````
#### OS 22.04

````
apt update && apt upgrade -y && update-grub && sleep 2 && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt upgrade && apt install -y bzip2 gzip coreutils screen curl unzip && wget -q https://raw.githubusercontent.com/kipas77pro/aku/main/setup2.sh && chmod +x setup2.sh && ./setup2.sh
````

### Update
````
wget -O update "raw.githubusercontent.com/kipas77pro/aku/main/options/update.sh" && chmod +x update
````

````
wget -O updatevray "raw.githubusercontent.com/kipas77pro/aku/main/updatevray.sh" && chmod +x updatevray
````

````
wget -O upray "raw.githubusercontent.com/kipas77pro/aku/main/upray.sh" && chmod +x upray
````

````
wget -O up-ssh-vpn "raw.githubusercontent.com/kipas77pro/aku/main/up-ssh-vpn.sh" && chmod +x up-ssh-vpn
````
### Menu Singapore

````
wget -O menu "raw.githubusercontent.com/kipas77pro/aku/main/opok/menu.sh" && chmod +x menu
````
## udp
````
wget -O udepe "raw.githubusercontent.com/kipas77pro/aku/main/udepe" && chmod +x udepe
````
