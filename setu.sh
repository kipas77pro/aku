#!/bin/bash
# UPLOAD ARYA BLITAR 081931615811

NC='\033[0m' # No Color
BIBlack='\033[1;90m'
BIRed='\033[1;91m'
green='\033[1;92m'
BIYellow='\033[1;93m'
BIBlue='\033[1;94m'
BIPurple='\033[1;95m'
BICyan='\033[1;96m'
BIWhite='\033[1;97m'
UWhite='\033[4;37m'
On_IPurple='\033[0;105m'
On_IRed='\033[0;101m'
IBlack='\033[0;90m'
IRed='\033[0;91m'
IGreen='\033[0;92m'
IYellow='\033[0;93m'
IBlue='\033[0;94m'
IPurple='\033[0;95m'
ICyan='\033[0;96m'
IWhite='\033[0;97m'
BGCOLOR='\e[1;97;101m' # WHITE RED

echo -e " <<<<< UPLOAD ARYA BLITAR >>>>>>"
echo -e "\033[0;37m Script Ini Version LifeTime "
echo -e " Tuk Infonya Silahkan Hubungi Admin"
echo -e " Version MultiPort Edision Stable "
echo -e " Sc All Os Mase... !!"
echo -e "\033[0;36m By Arya Blitar 081931615811 "
echo -e "\033[0;32m"
kunci="KANGEN521";
read -s -p "Masukkan Password : " pass
if [ $pass == $kunci ]
then cat login.sh
clear
else
echo -e "\033[0;31m Password Salah Sayank...!!"
echo -e "\033[0;32m Segera Hub. Admin 081931615811 "
exit
fi
echo -e "\033[0;32m SELAMAT ANDA BERHASIL MASUK & INSTALL"
sleep 3
clear
clear
# // Exporint IP AddressInformation
export IP=$( curl -sS icanhazip.com )

# // Clear Data
clear
clear && clear && clear
clear;clear;clear

# // Banner
echo -e "${YELLOW}----------------------------------------------------------${NC}"
echo -e " Dev > Script ${YELLOW}(${NC}${green} Stable Edition 2025 ${NC}${YELLOW})${NC}"
echo -e " Version All Os Multiport "
echo -e " Auther : ${green}Arya Blitar ${NC}"
echo -e " © Udanawu Blitar Jatim ${YELLOW}(${NC}2025 ${YELLOW})${NC}"
echo -e "${YELLOW}----------------------------------------------------------${NC}"
echo ""
sleep 2 

# // Checking Os Architecture
if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
    echo -e "${OK} Your Architecture Is Supported ( ${green}$( uname -m )${NC} )"
else
    echo -e "${EROR} Your Architecture Is Not Supported ( ${YELLOW}$( uname -m )${NC} )"
    exit 1
fi

# // Checking System
if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
    echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
    echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
else
    echo -e "${EROR} Your OS Is Not Supported ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    exit 1
fi

# // IP Address Validating
if [[ $IP == "" ]]; then
    echo -e "${EROR} IP Address ( ${YELLOW}Not Detected${NC} )"
else
    echo -e "${OK} IP Address ( ${green}$IP${NC} )"
fi

# // Validate Successfull
echo ""
read -p "$( echo -e "Press ${GRAY}[ ${NC}${green}Enter${NC} ${GRAY}]${NC} For Starting Installation") "
echo ""
clear
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear

apt install ruby -y
gem install lolcat
apt install wondershaper -y

echo -e "${green}Masuk Lah Temanten Baru...${NC}"
sleep 3
clear

mkdir -p /etc/data
user_ip=$(curl -s https://ipinfo.io/ip)

echo -e "${green}Sedang Melanjutkan proses...${NC}"
sleep 2

clear

# --- Detail API Bot Telegram ---
CHAT_ID="6430177985"
TOKEN="7567594287:AAGVeDwRq9QrNg6jSce30eOm9WiVtAWKxjA"

# --- Fungsi untuk Mengirim Pesan ke Telegram ---
send_telegram_message() {
    MESSAGE=$1
    BUTTON1_URL="https://t.me/aryapro"
    BUTTON2_URL="https://wa.me/6281931615811"
    BUTTON_TEXT1="Telegram "
    BUTTON_TEXT2="Whatsapp "

    RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d parse_mode="DANCOKBABI" \
        -d text="$MESSAGE" \
        -d reply_markup='{
                "inline_keyboard": [
                    [{"text": "'"$BUTTON_TEXT1"'", "url": "'"$BUTTON1_URL"'"}, {"text": "'"$BUTTON_TEXT2"'", "url": "'"$BUTTON2_URL"'"}]
                ]
            }')

}

# --- Konfigurasi Hostname ---
cd /root || exit 1
local_ip=$(hostname -I | cut -d' ' -f1)
host_name=$(hostname)

# Perbaiki file hosts jika diperlukan
if ! grep -q "^${local_ip} ${host_name}" /etc/hosts; then
    echo "${local_ip} ${host_name}" >> /etc/hosts
fi

# --- Fungsi Konversi Waktu ---
secs_to_human() {
    local jam=$(( $1 / 3600 ))
    local menit=$(( ($1 % 3600) / 60 ))
    local detik=$(( $1 % 60 ))
    echo "Waktu instalasi: ${jam} jam ${menit} menit ${detik} detik"
}

# --- Persiapan Direktori ---
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/aryapro/ipvps.conf
clear

# --- Fungsi Bar Progres (fun_bar) ---
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mUpdate Domain.. \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mUpdate Domain... \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}

clear
cd

# PERCUMA KAMU DENCRIPT PENASARAN YA MAS..
# TUNJUKKAN KARYAMU JANGAN MAIN BONGKAR AJA
# --- Pilihan Domain ---
echo -e " \033[1;37mPilih 1 & Masukin Domain Kalian ${NC}"
echo -e ""
until [[ $domain =~ ^1$ ]]; do
    read -p "    Please select number 1 : " domain
done

if [[ $domain == "1" ]]; then
    clear
    echo " "
    until [[ $dns1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        read -rp "Masukan domain kamu Disini : " -e dns1
    done
    echo ""
    mkdir -p /usr/bin
    rm -fr /usr/local/bin/xray
    rm -fr /etc/nginx
    rm -fr /usr/local/bin/stunnel
    rm -fr /usr/local/bin/stunnel4
    rm -fr /var/lib/aryapro/
    rm -fr /usr/bin/xray
    rm -fr /etc/xray
    rm -fr /usr/local/etc/xray
    mkdir -p /etc/nginx
    mkdir -p /var/lib/aryapro/
    mkdir -p /usr/bin/xray
    mkdir -p /etc/xray
    mkdir -p /usr/local/etc/xray
    mkdir -p /etc/xray
    mkdir -p /etc/v2ray
    touch /etc/xray/domain
    touch /etc/v2ray/domain
    echo "$dns1" > /etc/xray/domain
    echo "$dns1" > /etc/v2ray/domain
    echo "IP=$dns1" > /var/lib/aryapro/ipvps.conf
    clear
fi

echo -e "${green}Sedang Di Mulai..${NC}"
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p >/dev/null 2>&1

echo -e "${green}Dari Pertama...${NC}"
systemctl disable --now apparmor >/dev/null 2>&1
systemctl stop apparmor >/dev/null 2>&1
update-rc.d -f apparmor remove >/dev/null 2>&1 # Ini mungkin tidak ada di semua sistem, tapi aman.
apt-get purge apparmor apparmor-utils -y >/dev/null 2>&1

clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

echo -e "${green}Kita Install All Os Nggeh Mase...${NC}"
sleep 2
apt update -y && apt upgrade -y
apt install git curl python3 apt  figlet python3-pip apt-transport-https ca-certificates software-properties-common ntpdate wget netcat-openbsd ncurses-bin chrony jq -y
-y
wget https://github.com/fullstorydev/grpcurl/releases/download/v1.9.1/grpcurl_1.9.1_linux_x86_64.tar.gz -O /tmp/grpcurl.tar.gz && tar -xzf /tmp/grpcurl.tar.gz -C /tmp/ && sudo mv /tmp/grpcurl /usr/local/bin/ && sudo chmod +x /usr/local/bin/grpcurl
wget https://raw.githubusercontent.com/XTLS/Xray-core/main/app/stats/command/command.proto -O stats.proto
fi
clear
# Mulai donk
res1() {
    echo -e "${green}    Install Tools ...${NC}"
    wget https://raw.githubusercontent.com/Arya-Blitar22/header/refs/heads/main/header/tools.sh -O tools.sh >/dev/null 2>&1
    chmod +x tools.sh
    ./tools.sh >/dev/null 2>&1
}

res2() {
    echo -e "${green}    Install Menu ...${NC}"
    wget https://raw.githubusercontent.com/Arya-Blitar22/bangunan/main/koral/apem.zip
    unzip apem.zip
    chmod +x apem/*
    mv apem/* /usr/bin
    rm -rf apem
    rm -rf apem.zip
}

res3() {
    res1() {
    echo -e "${green}    Install Ssh-Ws...${NC}"
    wget https://raw.githubusercontent.com/Arya-Blitar22/bangunan/refs/heads/main/semen/insshws.sh -O insshws.sh >/dev/null 2>&1
    chmod +x insshws.sh
    ./insshws.sh >/dev/null 2>&1
    clear
   
}

res4() {
    echo -e "${green}    Memulai instalasi Ws-Pro${NC}"
    wget https://raw.githubusercontent.com/Arya-Blitar22/luwak/refs/heads/main/kirek/ssh-vpn.sh -O ssh-vpn.sh >/dev/null 2>&1
    chmod +x ssh-vpn.sh
    ./ssh-vpn.sh >/dev/null 2>&1
    sudo systemctl enable --now chrony.service >/dev/null 2>&1
    sudo systemctl restart chrony.service >/dev/null 2>&1
    clear
}

res5() {
    echo -e "${green}    Install Vray...${NC}" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/Arya-Blitar22/obat/refs/heads/main/panu/ins-xray.sh -O ins-xray.sh >/dev/null 2>&1
    chmod +x ins-xray.sh
    ./ins-xray.sh >/dev/null 2>&1
}

res6() {
    echo -e "${green}    Install Backup...${NC}" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/Arya-Blitar22/obat/refs/heads/main/sate/set-br.sh -O set-br.sh >/dev/null 2>&1
    chmod +x set-br.sh
    ./set-br.sh >/dev/null 2>&1
    clear
}

res7() {
    echo -e "${green}    Install UDP ...${NC}" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/Arya-Blitar22/obat/refs/heads/main/asu/udepe -O udepe >/dev/null 2>&1
    chmod +x udepe
    ./udepe >/dev/null 2>&1
    clear
}

res8() {
    echo -e "${green}    Mengkonfigurasi Dropbear...${NC}"
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
    sudo systemctl daemon-reload >/dev/null 2>&1
    sudo systemctl restart dropbear >/dev/null 2>&1
    sudo systemctl enable nginx >/dev/null 2>&1
    clear
}
# Jalan Tools
function SKT4100(){
    res0
    res1
    res2
    res3
    res4
    res5
    res6
    res7
    res8
}
SKT4100 # Memanggil fungsi SKT4100

if [ ! -f "/home/re_otm" ]; then
    echo "0" > /home/re_otm
fi

cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
    rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
    rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
    echo "Log All Account " > /etc/log-create-user.log
fi
history -c
aureb=$(cat /home/re_otm)
b=11
if [ "$aureb" -gt "$b" ]
then
    gg="PM"
else
    gg="AM"
fi
cd

curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
curl -s ipinfo.io/org?token=75082b4831f909 | cut -d " " -f 2-10 >> /etc/xray/isp
rm /root/setup7.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1

secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo ""
cd

IPVPS=$(curl -s https://ipinfo.io/ip)
HOSTNAME=$(hostname)
OS=$(lsb_release -d | awk '{print $2,$3,$4}')
ISP=$(curl -s https://ipinfo.io/org | awk '{print $2,$3,$4}')
REGION=$(curl -s ipinfo.io/region)
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')
DOMAIN=$(cat /etc/xray/domain)

MESSAGE="\`\`\`
❏━━━━━━━━━━━━━━━━━❏
         BAKOL KURSI
❏━━━━━━━━━━━━━━━━━❏
❖ Status        : Active
❖ Status SC     : Admin Access
❖ Linux OS      : $OS
❖ ISP           : $ISP
❖ IP VPS        : $IPVPS
❖ Area ISP      : $REGION
❖ Waktu         : $TIME
❖ Tanggal       : $DATE
❖ Domain        : $DOMAIN
❏━━━━━━━━***************━━━━━━━━━❏
      WA 081931615811
❏━━━━━━━******************━━━━━━━━❏
\`\`\`"

send_telegram_message "$MESSAGE"
clear
sleep 2
echo "===============-[ Script By Arya Blitar ]-==============="
echo ""
echo  "   >>> Service & Port"  | tee -a log-install.txt
echo  "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo  "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo  "   - Badvpn                  : 7100-7300" | tee -a log-install.txt
echo  "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo  "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo  "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo  "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo  "   - IPtables                : [ON]"  | tee -a log-install.txt
echo  "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo  "   - Autoreboot              : 05.00 GMT +7" | tee -a log-install.txt
echo  "   - AutoBackup              : 01.00 GMT +7" | tee -a log-install.txt
echo  "   - AutoKill Multi Login User" | tee -a log-install.txt
echo  "   - Auto Delete Expired Account" | tee -a log-install.txt
echo  "   - Fully automatic script" | tee -a log-install.txt
echo  "   - VPS settings" | tee -a log-install.txt
echo  "   - Restore Data" | tee -a log-install.txt
echo  "   - Full Orders For Various Services" | tee -a log-install.txt
echo "===============-[ Script By Arya Blitar ]-==============="
echo ""
echo  "------------------------------------------------------------"
echo -e "Wa Me +6281931615811"
echo  ""

echo -e "${green} Script Successfull Installed"
echo ""
read -p "$( echo -e "Press ${YELLOW}[ ${NC}${YELLOW}Enter${NC} ${YELLOW}]${NC} For reboot") "
reboot
