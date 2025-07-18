#!/bin/bash

vlx=$(grep -c -E "^#?# " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#!# " "/etc/xray/config.json")
let tra=$trx/2

NC='\033[0;37m'
BICyan='\033[0;34m'
ICyan='\033[0;36m'  
RED='\033[0;31m'
GREEN='\033[0;32m'
green='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\033[0;37m'
KN='\033[1;33m'
ORANGE='\033[0;33m'
PINK='\033[0;35m'

clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel4 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws_epro="${green}ON${NC}"
else
    status_ws_epro="${red} [OFF] ${NC} "
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
IPVPS=$(curl -sS ifconfig.me)
MEMOFREE=$(printf '%-1s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
LOADCPU=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
MODEL=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
CORE=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
DATEVPS=$(date +'%d/%m/%Y')
TIMEZONE=$(printf '%(%H:%M:%S)T')
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
clear
clear
clear
echo -e ""
echo -e "\E[44;1;39m ꧁࿇ SCRIPT SEDERHANA PENUH CINTA ࿇꧂ \E[0m"
echo -e ""
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │$NC\033[42m                   SYSTEM INFORMATION                ${BICyan}│${NC} "
echo -e "${BICyan} │ "
echo -e " ${BICyan}│  ${ICyan} Hostname     : ${NC}$HOSTNAME "
#echo -e " ${BICyan}│  ${ICyan} Public IP    : ${NC}$IPVPS ${NC} "
#echo -e " ${BICyan}│  ${ICyan} Domain       : ${NC}$(cat /etc/xray/domain) "
echo -e " ${BICyan}│  ${ICyan} ISP          : ${NC}$ISP "
echo -e " ${BICyan}│  ${ICyan} Total RAM    : ${NC}$uram / $tram MB ${NC}"
echo -e " ${BICyan}│  ${ICyan} Usage Memory :${NC} $MEMOFREE "
echo -e " ${BICyan}│  ${ICyan} LoadCPU      : ${NC}$LOADCPU% "
echo -e " ${BICyan}│  ${ICyan} Core System  : ${NC}$CORE "
echo -e " ${BICyan}│  ${ICyan} System OS    : ${NC}$MODEL "
echo -e " ${BICyan}│  ${ICyan} Date         : ${NC}$DATEVPS "
echo -e " ${BICyan}│  ${ICyan} Time         : ${NC}$TIMEZONE "
echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
echo -e " ${BICyan}╭═════════════════════════════════════════════════════╮${NC}"
echo -e "${BICyan} │                    ${NC}SSH    ${ICyan}: ${ORANGE}$ssh1      ${NC} "
echo -e "${BICyan} │                    ${NC}VMESS ${ICyan} : ${ORANGE}$vma     ${NC} "
echo -e "${BICyan} │                    ${NC}VLESS ${ICyan} : ${ORANGE}$vla     ${NC} "
echo -e "${BICyan} │                    ${NC}TROJAN ${ICyan}: ${ORANGE}$tra     ${NC} "
echo -e " ${BICyan}╰═════════════════════════════════════════════════════╯${NC}"
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "    ${NC} SSH ${ORANGE}: ${RED}$ressh"" ${NC} NGINX ${ORANGE}: ${RED}$resngx"" ${NC}  XRAY ${ORANGE}: ${RED}$resv2r"" ${NC} TROJAN ${ORANGE}: ${RED}$resv2r"
echo -e "  ${NC}     STUNNEL4 ${ORANGE}: ${RED}$resst" "${NC} DROPBEAR ${ORANGE}: ${RED}$resdbr" "${NC} SSH-WS ${ORANGE}: ${RED}$status_ws_epro"
echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "      ${NC} Hari ini                    Bulan ini  ${NC}"
echo -e "    ${ORANGE}↓↓ Down:${NC} $dtoday${ORANGE}          ↓↓ Down:${NC} $dmon${NC}   "
echo -e "    ${ORANGE}↑↑ Up  : ${NC}$utoday   ${ORANGE}       ↑↑ Up  : ${NC}$umon${NC}   "
echo -e "    ${ORANGE}≈ Total:${NC} $ttoday  ${ORANGE}        ≈ Total: ${NC}$tmon${NC}   "
echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
echo -e "$BICyan   ┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BICyan   │$NC\033[42m                    INFO MENU                    $BICyan│$NC"
echo -e "$BICyan   └─────────────────────────────────────────────────┘${NC}"
echo -e " ${BICyan}╭═════════════════════════════════════════════════════╮${NC}"
echo -e "${BICyan} │    ${ICyan}[${ORANGE}01${ICyan}]${NC} • SSH/WS     "   "${BICyan}│    ${ICyan}[${ORANGE}08${ICyan}]${NC} • INFO PORT         ${BICyan}│${NC}   "
echo -e "${BICyan} │    ${ICyan}[${ORANGE}02${ICyan}]${NC} • VMESS      "  "${BICyan}│    ${ICyan}[${ORANGE}09${ICyan}]${NC} • GOTOP X RAM       ${BICyan}│${NC}"
echo -e "${BICyan} │    ${ICyan}[${ORANGE}03${ICyan}]${NC} • VLESS      "   "${BICyan}│    ${ICyan}[${ORANGE}10${ICyan}]${NC} • INFO RUN          ${BICyan}│  ${NC} "
echo -e "${BICyan} │    ${ICyan}[${ORANGE}04${ICyan}]${NC} • TROJAN     "  "${BICyan}│    ${ICyan}[${ORANGE}11${ICyan}] ${NC}• UPDATE MENU       ${BICyan}│ ${NC}      "
echo -e "${BICyan} │    ${ICyan}[${ORANGE}05${ICyan}]${NC} • DOMAIN     "     "${BICyan}│    ${ICyan}[${ORANGE}12${ICyan}]${NC} • CEK LOG VMES      ${BICyan}│${NC}"
echo -e "${BICyan} │    ${ICyan}[${ORANGE}06${ICyan}]${NC} • BACKUP   "  "  ${BICyan}│    ${ICyan}[${ORANGE}13${ICyan}]${NC} • MENU SYSTEM       ${BICyan}│${NC}"
echo -e "${BICyan} │    ${ICyan}[${ORANGE}07${ICyan}]${NC} • SPEEDTEST  "  "${BICyan}│    ${ICyan}[${ORANGE}14${ICyan}]${NC} • EXIT              ${BICyan}│${NC}"
echo -e " ${BICyan}╰═════════════════════════════════════════════════════╯${NC}"
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}  ${RED}▁ ${CYAN}▂ ${GREEN}▄ ${ORANGE}▅${PINK} ▆${GREEN} ▇ ${RED}█${BLUE}𒆜${CYAN} ༻${NC}  SCRIPT ARYA BLITAR ${BLUE}༺ ${RED}𒆜${GREEN}█ ${ORANGE}▇ ${CYAN}▆ ${RED}▅ ${GREEN}▄ ${ORANGE}▂ ${PINK}▁\E[0m"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e " ${BICyan}┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${BICyan}│ ${ORANGE} Version       : ${NC}PREMIUM 2025 V 2030  ${NC}"
echo -e " ${BICyan}│ ${ORANGE} TIPEXXX       : ${NC}AL OS STUNEL4   ${NC}"
echo -e " ${BICyan}│ ${ORANGE} Version       : ${NC}LIFETIME  ${NC}"
echo -e " ${BICyan}│ ${ORANGE} OWNER         : ${NC}WA 081931615811 ${NC}"
echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; addhost ;;
6) clear ; menu-backup ;;
7) clear ; speedtest ;;
8) clear ; info ;;
9) clear ; gotop ;;
10) clear ; running ;;
11) clear ; update ;;
12) clear ; babi ;;
13) clear ; menu-set ;;
14) clear ; exit ;;
0) clear ; menu ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
