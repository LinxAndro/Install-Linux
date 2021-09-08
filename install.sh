#!/bin/bash
n="\033[0m"

if [ -f "/data/data/com.termux/files/usr/bin/curl" ]
	then
		printf "${n}"
	else
		printf "${n}"
		pkg install curl -y
fi

Menu(){
clear
echo -e "[1] Debian"
echo -e "[2] Ubuntu"
echo -e "[3] Parrot"
echo -e "[x] Cancel"
}

Install(){
Menu
read -p $'\n[ Select OS ] > ' select
if [ $select == 1 ]
	then
		echo; bash <(curl -s https://raw.githubusercontent.com/LinxAndro/Install-Linux/master/Installer/debian.sh)

elif [ $select == 2 ]
	then
		echo; bash <(curl -s https://raw.githubusercontent.com/LinxAndro/Install-Linux/master/Installer/ubuntu.sh)

elif [ $select == 3 ]
	then
		echo; bash <(curl -s https://raw.githubusercontent.com/LinxAndro/Install-Linux/master/Installer/parrot.sh)

elif [ $select == x ]
	then
		exit 1

else
	Install

fi
}

Install
