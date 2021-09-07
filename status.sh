#!/bin/bash
g="\033[0;32m"
r="\033[1;31m"
n="\033[0m"

debian="/data/data/com.termux/files/usr/bin/debian"
ubuntu="/data/data/com.termux/files/usr/bin/ubuntu"
parrot="/data/data/com.termux/files/usr/bin/parrot"

if [ -f "$debian" ]
	then
		check=1
		echo -e "${n}Debian: ${g}installed${n}"
fi

if [ -f "$ubuntu" ]
	then
		check=1
		echo -e "${n}Ubuntu: ${g}installed${n}"
fi

if [ -f "$parrot" ]
	then
		check=1
		echo -e "${n}Parrot: ${g}installed${n}"
fi

if [ "$check" != 1 ]
	then
		echo -e "${r}Nothing is installed!${n}"
fi
