````
apt update && apt upgrade -y && update-grub && sleep 2 && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt upgrade && apt install -y bzip2 gzip coreutils screen curl unzip && wget -q https://raw.githubusercontent.com/kipas77pro/aku/main/setup.sh && chmod +x setup.sh && ./setup.sh
````

````
wget -O update "raw.githubusercontent.com/kipas77pro/aku/main/options/update.sh" && chmod +x update
````

````
wget -O updatevray "raw.githubusercontent.com/kipas77pro/aku/main/updatevray.sh" && chmod +x updatevray
````

````
wget -O upray "raw.githubusercontent.com/kipas77pro/aku/main/upray.sh" && chmod +x upray
````
