#!/bin/bash
g="\033[0;32m"
r="\033[1;31m"
n="\033[0m"

Detect(){
if [ -f "$exe" ]
	then
		printf "\nUninstalling..."
	else
		echo -e "\n${os}: ${r}not installed${n}"
		exit 1
fi
}

Menu(){
clear
printf "${n}"
echo "[1] Debian"
echo "[2] Ubuntu"
echo "[3] Parrot"
echo "[x] Cancel"
}

Uninstall(){
Menu
read -p $'\n[ Select OS ] > ' select
if [ $select == 1 ]
	then
		exe="/data/data/com.termux/files/usr/bin/debian"
		os="Debian"
		Detect
		rm -rf $exe .debian-fs .debian-binds
		printf " ${g}Done\n${n}"

elif [ $select == 2 ]
	then
		exe="/data/data/com.termux/files/usr/bin/ubuntu"
		os="Ubuntu"
		Detect
		rm -rf $exe .ubuntu-fs .ubuntu-binds
		printf " ${g}Done\n${n}"

elif [ $select == 3 ]
	then
		exe="/data/data/com.termux/files/usr/bin/parrot"
		os="Parrot"
		Detect
		rm -rf $exe .parrot-fs .parrot-binds
		printf " ${g}Done\n${n}"

elif [ $select == x ]
	then
		exit 1

else
	Uninstall

fi
}

Uninstall
