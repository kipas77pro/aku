#!/bin/bash

GitUser="kipas77pro"
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
clear
echo ""
sleep 2
echo -e "\e[1;36mStart Update For New Version, Please Wait..\e[m"
sleep 2
clear
echo -e "\e[0;32mGetting New Version Script..\e[0m"
sleep 1
echo ""
# UPDATE RUN-UPDATE
cd /usr/bin
wget -O run-update "https://raw.githubusercontent.com/${GitUser}/tunel/main/options/update.sh" >/dev/null 2>&1
chmod +x run-update
# RUN UPDATE
echo ""
clear
echo -e "\e[0;32mPlease Wait...!\e[0m"
sleep 6
clear
echo ""
echo -e "\e[0;32mNew Version Downloading started!\e[0m"
sleep 2
cd /usr/bin

rm -rf autoreboot
rm -rf clearlog
rm -rf running
rm -rf speedtest
rm -rf cek-bandwidth
rm -rf menu-vless
rm -rf menu-vmess
rm -rf menu-trojan
rm -rf menu-ssh
rm -rf menu-backup
rm -rf menu
rm -rf addhost
rm -rf certxray
rm -rf menu-set
rm -rf babi
rm -rf xp
rm -rf info
rm -rf tendang
rm -rf menu


wget -q -O /usr/bin/autoreboot "https://raw.githubusercontent.com/kipas77pro/tunel/main/options/autoreboot.sh"
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/kipas77pro/tunel/main/options/restart.sh"
wget -q -O /usr/bin/clearlog "https://raw.githubusercontent.com/kipas77pro/tunel/main/options/clearlog.sh"
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/kipas77pro/tunel/main/options/running.sh"
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/kipas77pro/tunel/main/tools/speedtest_cli.py"
wget -q -O /usr/bin/cek-bandwidth "https://raw.githubusercontent.com/kipas77pro/tunel/main/options/cek-bandwidth.sh"
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu-vless.sh"
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu-vmess.sh"
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu-trojan.sh"
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu-ssh.sh"
wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu-backup.sh"
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu.sh"
wget -q -O /usr/bin/addhost "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/addhost.sh"
wget -q -O /usr/bin/certxray "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/cf.sh"
wget -q -O /usr/bin/menu-set "https://raw.githubusercontent.com/kipas77pro/tunel/main/menu/menu-set.sh"
wget -q -O /usr/bin/babi "https://raw.githubusercontent.com/kipas77pro/tunel/main/ssh/babi.sh"
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/kipas77pro/tunel/main/ssh/xp.sh"
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/kipas77pro/tunel/main/options/info.sh"

chmod +x /usr/bin/autoreboot
chmod +x /usr/bin/restart
chmod +x /usr/bin/clearlog
chmod +x /usr/bin/running
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/cek-bandwidth
chmod +x /usr/bin/menu-vless
chmod +x /usr/bin/menu-vmess
chmod +x /usr/bin/menu-trojan
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/menu-backup
chmod +x /usr/bin/menu
chmod +x /usr/bin/babi
chmod +x /usr/bin/xp
chmod +x /usr/bin/addhost
chmod +x /usr/bin/certxray
chmod +x /usr/bin/menu-set
chmod +x /usr/bin/info

clear
echo -e ""
echo -e "\e[0;32mDownloaded successfully!\e[0m"
echo ""
sleep 2
echo -e "\e[0;32mPatching... OK!\e[0m"
sleep 1
echo ""
echo -e "\e[0;32mSucces Update Script For New Version\e[0m"
cd
rm -f update.sh
clear
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[42;1;37m        SCRIPT UDAH UPDATED             \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
x)
clear
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
esac
