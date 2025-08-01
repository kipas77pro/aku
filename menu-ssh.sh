#!/bin/bash
NC='\033[0;37m' 
PURPLE='\033[0;34m' 
GREEN='\033[0;32m' 
RED='\033[0;31m'
BIWhite='\033[1;97m'  
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

clear
function del(){
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m               MEMBER SSH                 \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"      
echo "USERNAME          EXP DATE          STATUS"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED${NORMAL}"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED${NORMAL}"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "\E[42;1;37m                DELETE USER               \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"  
echo ""
read -p "Username SSH to Delete : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna > /dev/null 2>&1
        echo -e "User $Pengguna was removed."
else
        echo -e "Failure: User $Pengguna Not Exist."
fi

read -n 1 -s -r -p "Press any key to back on menu"

menu-ssh
}
function autodel(){
clear
               hariini=`date +%d-%m-%Y`
               echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
               echo -e "\E[42;1;37m                AUTO DELETE               \E[0m"
               echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"  
               echo "Thank you for removing the EXPIRED USERS"
               echo -e "$PURPLE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"  
               cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
               totalaccounts=`cat /tmp/expirelist.txt | wc -l`
               for((i=1; i<=$totalaccounts; i++ ))
               do
               tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
               username=`echo $tuserval | cut -f1 -d:`
               userexp=`echo $tuserval | cut -f2 -d:`
               userexpireinseconds=$(( $userexp * 86400 ))
               tglexp=`date -d @$userexpireinseconds`             
               tgl=`echo $tglexp |awk -F" " '{print $3}'`
               while [ ${#tgl} -lt 2 ]
               do
               tgl="0"$tgl
               done
               while [ ${#username} -lt 15 ]
               do
               username=$username" " 
               done
               bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
               echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
               todaystime=`date +%s`
               if [ $userexpireinseconds -ge $todaystime ] ;
               then
		    	:
               else
               echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >> /usr/local/bin/deleteduser
	           echo "Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini"
               userdel $username
               fi
               done
               echo " "
               echo -e "$PURPLE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
               
               read -n 1 -s -r -p "Press any key to back on menu"
               menu-ssh
        
}
function ceklim(){
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m          CEK USER MULTILOGIN      \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [ -e "/root/log-limit.txt" ]; then
echo "User Who Violate The Maximum Limit";
echo "Time - Username - Number of Multilogin"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
cat /root/log-limit.txt
else
echo " No user has committed a violation"
echo " "
echo " or"
echo " "
echo " The user-limit script not been executed."
fi
echo " ";
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " ";
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
function cek(){
if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure";
fi
                
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo -e "\033[0;34m┌──────────────────────────────────────────┐\033[0m"
echo "         Memeriksa login Dropbear";
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/login-db.txt;
for PID in "${data[@]}"
do
            cat /tmp/login-db.txt | grep "dropbear\[$PID\]" > /tmp/login-db-pid.txt;
            NUM=`cat /tmp/login-db-pid.txt | wc -l`;
            USER=`cat /tmp/login-db-pid.txt | awk '{print $10}'`;
            IP=`cat /tmp/login-db-pid.txt | awk '{print $12}'`;
            if [ $NUM -eq 1 ]; then
                    echo "$PID - $USER - $IP";
                    fi
done
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
echo " "
echo -e "\033[0;34m┌──────────────────────────────────────────┐\033[0m"
echo "         Memeriksa login OpenSSH";
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/login-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

for PID in "${data[@]}"
do
            cat /tmp/login-db.txt | grep "sshd\[$PID\]" > /tmp/login-db-pid.txt;
            NUM=`cat /tmp/login-db-pid.txt | wc -l`;
            USER=`cat /tmp/login-db-pid.txt | awk '{print $9}'`;
            IP=`cat /tmp/login-db-pid.txt | awk '{print $11}'`;
            if [ $NUM -eq 1 ]; then
                    echo "$PID - $USER - $IP";
        fi
done
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
echo ""
echo -e "\033[0;34m┌──────────────────────────────────────────┐\033[0m"
echo "    Username  |  IP Address  |  Connected";
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
            cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
            cat /tmp/vpn-login-tcp.txt
fi
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"

if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
echo " "
echo -e "\033[0;34m┌──────────────────────────────────────────┐\033[0m"
echo "    Username  |  IP Address  |  Connected";
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
            cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
            cat /tmp/vpn-login-udp.txt
            
nama=$(cat /etc/xray/username)
print_rainbow() {
    local text="$1"
    local warna_file="/etc/warna"

    # Inisialisasi warna default
    local start_r=0 start_g=255 start_b=150
    local mid_r=0 mid_g=150 mid_b=255
    local end_r=0 end_g=255 end_b=150

    # Fungsi untuk membaca nilai numerik dari file
    function get_value() {
        local key="$1"
        local value=$(grep -E "^$key=" "$warna_file" | cut -d'=' -f2 | tr -d '[:space:]')
        echo "${value:-0}"
    }

    # Jika file warna ada, baca isinya
    if [[ -f "$warna_file" ]]; then
        start_r=$(get_value "start_r")
        start_g=$(get_value "start_g")
        start_b=$(get_value "start_b")

        mid_r=$(get_value "mid_r")
        mid_g=$(get_value "mid_g")
        mid_b=$(get_value "mid_b")

        end_r=$(get_value "end_r")
        end_g=$(get_value "end_g")
        end_b=$(get_value "end_b")
    fi

    # Jalankan awk dengan warna yang sudah dimuat dari file
    echo "$text" | awk -v start_r="$start_r" -v start_g="$start_g" -v start_b="$start_b" \
                        -v mid_r="$mid_r" -v mid_g="$mid_g" -v mid_b="$mid_b" \
                        -v end_r="$end_r" -v end_g="$end_g" -v end_b="$end_b" '
    {
        len = length($0);
        for (i = 1; i <= len; i++) {
            progress = (i - 1) / (len - 1);
            if (progress < 0.5) {
                factor = progress * 2;
                r = int((1 - factor) * start_r + factor * mid_r);
                g = int((1 - factor) * start_g + factor * mid_g);
                b = int((1 - factor) * start_b + factor * mid_b);
            } else {
                factor = (progress - 0.5) * 2;
                r = int((1 - factor) * mid_r + factor * end_r);
                g = int((1 - factor) * mid_g + factor * end_g);
                b = int((1 - factor) * mid_b + factor * end_b);
            }
            printf "\033[38;2;%d;%d;%dm%s", r, g, b, substr($0, i, 1);
        }
        print "\033[0m";
    }'
}
garis(){
print_rainbow " ────────────────────────────────────────────────"
}
garis_bawah(){
print_rainbow " └──────────────────────────────────────────────┘"
}
garis_atas(){
print_rainbow " ┌──────────────────────────────────────────────┐"
}
garis_tebal(){
print_rainbow " ════════════════════════════════════════════════"
}

center() {
    BOX_WIDTH=48
    TEXT="$1"
    TEXT_LENGTH=${#TEXT}
    TEXT_CLEAN=$(echo -e "$TEXT" | sed 's/\x1b\[[0-9;]*m//g')
    TEXT_LENGTH=${#TEXT_CLEAN}
    # Hitung padding
    LEFT_PADDING=$(( (BOX_WIDTH - TEXT_LENGTH) / 2 ))
    RIGHT_PADDING=$(( BOX_WIDTH - TEXT_LENGTH - LEFT_PADDING ))

    # Cetak dengan warna menggunakan printf
    printf "%*s%s%*s\n" "$LEFT_PADDING" "" "$TEXT" "$RIGHT_PADDING" ""
}

#function Sc_Credit(){
BOX_WIDTH=48
TEXT="SCRIPT BY ARYA BLITAR$nama"
TEXT_LENGTH=${#TEXT}
LEFT_PADDING=$(( (BOX_WIDTH - TEXT_LENGTH) / 2 ))
RIGHT_PADDING=$(( BOX_WIDTH - TEXT_LENGTH - LEFT_PADDING ))
LEFT_SPACE=$(printf '%*s' $LEFT_PADDING '')
RIGHT_SPACE=$(printf '%*s' $RIGHT_PADDING '')
print_rainbow " ════════════════════════════════════════════════"
print_rainbow " ${LEFT_SPACE}${TEXT}${RIGHT_SPACE}"
print_rainbow " ════════════════════════════════════════════════"
read -p "Tekan Enter untuk kembali ke menu..."
menu-ssh

function Arya_Banner() {
clear
BOX_WIDTH=48
TEXT="[ USER LOGIN UDP ]"
TEXT_LENGTH=${#TEXT}
LEFT_PADDING=$(( (BOX_WIDTH - TEXT_LENGTH) / 2 ))
RIGHT_PADDING=$(( BOX_WIDTH - TEXT_LENGTH - LEFT_PADDING ))
LEFT_SPACE=$(printf '%*s' $LEFT_PADDING '')
RIGHT_SPACE=$(printf '%*s' $RIGHT_PADDING '')
print_rainbow " ════════════════════════════════════════════════"
print_rainbow " ${LEFT_SPACE}${TEXT}${RIGHT_SPACE}"
print_rainbow " ════════════════════════════════════════════════"
}
clear
clear
echo " "
echo " "
sed -i "d" /var/log/udp.log 
sed -i "d" /tmp/login-udp-db1.txt
journalctl -u udp-custom -n 500 > /var/log/udp.log
cat /var/log/udp.log | grep -i "Client connected" > /tmp/login-udp.txt;
cat /var/log/udp.log | grep -i "Client disconnected" | awk '{print $14}' | cut -d ":" -f 2 > /tmp/login-udp1.txt;
data=(`cat /tmp/login-udp.txt | awk '{print $9}' | cut -d ":" -f 3 | cut -d "]" -f 1`)
for akun in "${data[@]}"
do
            cat /tmp/login-udp.txt | grep -wE "$akun" | awk '{print $9" "$10}'> /tmp/login-udp-db.txt;
            IP=`cat /tmp/login-udp-db.txt | awk '{print $1}' | cut -d ":" -f 2`;
            USER=`cat /tmp/login-udp-db.txt | awk '{print $2}' | cut -d ":" -f 2 | cut -d "]" -f 1`;
                    echo "$USER $IP"  >> /tmp/login-udp-db1.txt;
done
sed -i '/^[[:digit:]]/d' /tmp/login-udp-db1.txt
sed -i '/[[:digit:]]$/!d' /tmp/login-udp-db1.txtt
sed -i "d" /tmp/login-udp-fix.txt
cat /tmp/login-udp-db1.txt | sort | uniq > /tmp/login-udp-fix.txt
clear
data3=(`cat /tmp/login-udp-fix.txt | awk '{print $2}'`)
Arya_Banner
garis_atas
for akun in "${data3[@]}"
do
ipon=$(cat /tmp/login-udp.txt | grep -wE "$akun" | wc -l)
ipof=$(cat /tmp/login-udp1.txt | grep -wE "$akun" | wc -l)
let jum=(${ipon}-${ipof})
if [[ $jum -gt "0" ]]; then
 USER=`cat /tmp/login-udp-fix.txt | grep -wE "$akun" | awk '{print $1}' | uniq`;
 IP=`cat /tmp/login-udp-fix.txt | grep -wE "$akun" | awk '{print $2}' | uniq`;
printf "  %-13s %-7s %-8s %2s\n" "Aktif" "$USER" "$IP"
else
echo -ne
fi
done
garis_bawah
Sc_Credit
 cekudp.temp1.sh 
fi
echo -e "\033[0;34m└──────────────────────────────────────────┘\033[0m"
echo "";
#echo ""
echo -e "\033[0;33m┌──────────────────────────────────────────┐\033[0m"
echo -e "      Autoscript By Arya Blitar       "
echo -e "\033[0;33m└──────────────────────────────────────────┘\033[0m"
echo ""

rm -f /tmp/login-db-pid.txt
rm -f /tmp/login-db.txt
#rm -f /tmp/vpn-login-tcp.txt
#rm -f /tmp/vpn-login-udp.txt
read -n 1 -s -r -p "Press any key to back on menu"

menu-ssh
}
function member(){
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m               MEMBER SSH                 \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"      
echo "USERNAME          EXP DATE          STATUS"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED${NORMAL}"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED${NORMAL}"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "Account number: $JUMLAH user"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
menu-ssh
}
function renew(){
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m               MEMBER SSH                 \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"      
echo "USERNAME          EXP DATE          STATUS"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED${NORMAL}"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED${NORMAL}"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m            Perpanjang  User              \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"  
echo
read -p "Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m            Perpanjang  User              \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"  
echo -e ""
echo -e " Username : $User"
echo -e " Days Added : $Days Days"
echo -e " Expires on :  $Expiration_Display"
echo -e ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
else
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m            Perpanjang  User              \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"  
echo -e ""
echo -e "   Username Doesnt Exist      "
echo -e ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu-ssh
}
function autokill(){
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[42;1;37m             AUTOKILL SSH          \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Status Autokill : $sts        "
echo -e ""
echo -e "[1]  AutoKill After 5 Minutes"
echo -e "[2]  AutoKill After 10 Minutes"
echo -e "[3]  AutoKill After 15 Minutes"
echo -e "[4]  Turn Off AutoKill/MultiLogin"
echo -e "[x]  Menu"
echo ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
read -p "Select From Options [1-4 or x] :  " AutoKill
read -p "Multilogin Maximum Number Of Allowed: " max
echo -e ""
case $AutoKill in
                1)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >/etc/cron.d/tendang
                echo "*/5 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang && chmod +x /etc/cron.d/tendang
                echo "" > /root/log-limit.txt
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 5 Minutes"      
                echo -e ""
                echo -e "======================================"
                service cron reload >/dev/null 2>&1
                service cron restart >/dev/null 2>&1                                                                 
                ;;
                2)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >/etc/cron.d/tendang
                echo "*/10 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang && chmod +x /etc/cron.d/tendang
                echo "" > /root/log-limit.txt
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 10 Minutes"
                echo -e ""
                echo -e "======================================"
                service cron reload >/dev/null 2>&1
                service cron restart >/dev/null 2>&1
                ;;
                3)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >/etc/cron.d/tendang
                echo "*/15 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang && chmod +x /etc/cron.d/tendang
                echo "" > /root/log-limit.txt
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 15 Minutes"
                echo -e ""
                echo -e "======================================"
                service cron reload >/dev/null 2>&1
                service cron restart >/dev/null 2>&1          
                ;;
                4)
                rm -fr /etc/cron.d/tendang
                echo "" > /root/log-limit.txt
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      AutoKill MultiLogin Turned Off"
                echo -e ""
                echo -e "======================================"
                service cron reload >/dev/null 2>&1
                service cron restart >/dev/null 2>&1
                ;;
                x)
                menu
                ;;
                *)
                echo "Please enter an correct number"
                ;;
        esac
read -n 1 -s -r -p "Press any key to back on menu"
menu-ssh
}
clear
echo -e "${PURPLE}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${PURPLE} \E[42;1;37m                     SSH MENU                    ${PURPLE}│$NC"
echo -e "${PURPLE}└─────────────────────────────────────────────────┘${NC}"
echo -e "${PURPLE}┌───────────────────────────────────────────────┐${NC}"
echo -e "     ${GREEN}[1]${NC}  Create Ssh Account "
echo -e "     ${GREEN}[2]${NC}  Trial Ssh Acoount  "
echo -e "     ${GREEN}[3]${NC}  Delete Ssh Acoount  "
echo -e "     ${GREEN}[4]${NC}  Perpanjang Ssh Account  "
echo -e "     ${GREEN}[5]${NC}  Cek User Login "
echo -e "     ${GREEN}[6]${NC}  Cek User Multi Log "
echo -e "     ${GREEN}[7]${NC}  Auto Del User Exp  "
echo -e "     ${GREEN}[8]${NC}  Auto Kill User Ssh "
echo -e "     ${GREEN}[9]${NC}  Cek All Member Ssh "
echo -e "     ${GREEN}[10]${NC} Tendang User Multi"
echo -e " "
echo -e "     ${GREEN}[0]${NC} Back To Menu      "
echo -e "${PURPLE}└───────────────────────────────────────────────┘${NC}"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; usernew ;;
2) clear ; trialssh ;;
3) clear ; del ;;
4) clear ; renew;;
5) clear ; cek ;;
6) clear ; ceklim ;;
7) clear ; autodel ;;
8) clear ; autokill ;;
9) clear ; member ;;
10) clear ; tendang ;;
0) clear ; menu ;;
*) echo -e "" ; echo "Press any key to back on menu" ; sleep 1 ; menu ;;
esac
