#!/bin/bash
if [ -f "/data/data/com.termux/files/usr/bin/wget" ]
	then
		printf ""
	else
		pkg install wget -y
fi

file="installer.sh"

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
		echo
		wget -q -O $file "https://raw.githubusercontent.com/LinxAndro/Install-Linux/master/Installer/debian.sh"
		bash $file
		rm -f $file

elif [ $select == 2 ]
	then
		echo
		wget -q -O $file "https://raw.githubusercontent.com/LinxAndro/Install-Linux/master/Installer/ubuntu.sh"
		bash $file
		rm -f $file

elif [ $select == 3 ]
	then
		echo
		wget -q -O $file "https://raw.githubusercontent.com/LinxAndro/Install-Linux/master/Installer/parrot.sh"
		bash $file
		rm -f $file

elif [ $select == x ]
	then
		exit 1

else
	Install

fi
}

Install