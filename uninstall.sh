#!/bin/bash
g="\033[0;32m"
r="\033[1;31m"
n="\033[0m"

Detect(){
if [ -f "$bin" ]
	then
		printf "\nUninstalling..."
	else
		echo -e "\n${r}OS not detected!${n}"
		exit 1
fi
}

Menu(){
clear
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
		bin="/data/data/com.termux/files/usr/bin/debian"
		Detect
		rm -f $bin
		rm -rf debian-fs debian-binds
		printf " ${g}Done\n${n}"

elif [ $select == 2 ]
	then
		bin="/data/data/com.termux/files/usr/bin/ubuntu"
		Detect
		rm -f $bin
		rm -rf ubuntu-fs ubuntu-binds
		printf " ${g}Done\n${n}"

elif [ $select == 3 ]
	then
		bin="/data/data/com.termux/files/usr/bin/parrot"
		Detect
		rm -f $bin
		rm -rf parrot-fs parrot-binds
		printf " ${g}Done\n${n}"

elif [ $select == x ]
	then
		exit 1

else
	Uninstall

fi
}

Uninstall