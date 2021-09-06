#!/bin/bash
g="\033[0;32m"
r="\033[1;31m"
n="\033[0m"

folder="debian-fs"
tarball="debian-rootfs.tar.xz"
exe="debian.sh"

if [ -f "/data/data/com.termux/files/usr/bin/proot" ]; then
printf ""
else
pkg install proot -y
fi

if [ -f "/data/data/com.termux/files/usr/bin/wget" ]; then
printf ""
else
pkg install wget -y
fi

if [ -d "$folder" ]; then
first=1
echo -e "${g}Skip downloading${n}"
fi

if [ "$first" != 1 ]; then
	if [ ! -f $tarball ]; then
		printf "Downloading Rootfs"
		case `dpkg --print-architecture` in
		aarch64)
			archurl="arm64" ; size="75MB" ;;
		arm)
			archurl="armhf" ; size="74MB" ;;
		amd64)
			archurl="amd64" ; size="80MB" ;;
		x86_64)
			archurl="amd64" ; size="80MB" ;;
		i*86)
			archurl="i386" ; size="81MB" ;;
		x86)
			archurl="i386" ; size="81MB" ;;
		*)
			echo -e "${r}Unknown architecture!${n}"; exit 1 ;;
		esac
		printf " (${size})..."
		wget -q -O $tarball "https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Rootfs/Debian/$archurl/debian-rootfs-$archurl.tar.xz"
		printf " ${g}Done\n${n}"
	fi
	mkdir "$folder"
	cd "$folder"
	printf "Decompressing Rootfs..."
	proot --link2symlink tar -xJf ${HOME}/${tarball}||:
	printf " ${g}Done\n${n}"
	cd "$HOME"
fi

mkdir debian-binds

printf "Making launcher..."
cat > $exe <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $HOME/$folder"
if [ -n "\$(ls -A $HOME/debian-binds)" ]; then
    for f in $HOME/debian-binds/*; do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b $HOME/$folder/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b $HOME:/root"
## uncomment the following line to mount /sdcard directly to /
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ]; then
    exec \$command
else
    \$command -c "\$com"
fi
EOM
termux-fix-shebang $exe
chmod +x $exe
mv $exe /data/data/com.termux/files/usr/bin/debian
printf " ${g}Done\n${n}"

printf "Removing cache..."
rm $tarball
printf " ${g}Done\n${n}"

echo -e "Run it with the command: ${g}debian${n}"