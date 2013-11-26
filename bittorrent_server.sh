#!/bin/sh

# Note: This script must be run as root.

# Script to install all packages necessary to build a torrent box with NAS access to the downloaded files.
# This script is designed for a Raspberry Pi running the Raspbian distro, but may be usable on other machines running Debian 7 (Wheezy) or its derivatives.
# Once this script has run successfully, you can access the Transmission web interface by going to 'http://<ip of your pi>:9091'.
# You can access the NAS by connecting to 'smb://<ip of your pi>/Transmission' using your preferred client and entering your chosen username and password.
# For Windows OSs the NAS link will be '\\<ip of your pi>\Transmission'.

do_install () {
	echo "[+] Update system? [y/n]: "
	read UPDATE
	if [ ${UPDATE} = "y" ]; then
		echo "[+] Updating System"
		apt-get update
		apt-get -y dist-upgrade
	fi

	echo "[+] Installing Transmission and Samba"
	apt-get -y install transmission-daemon samba samba-common-bin

	echo "[+] Configuring Transmission"
	service transmission-daemon stop
	sed -i -re 's/(rpc-authentication-required\":\ )([a-z]+)*/\1false/g' /etc/transmission-daemon/settings.json
	sed -i -re 's/(rpc-whitelist-enabled\":\ )([a-z]+)*/\1false/g' /etc/transmission-daemon/settings.json
	sed -i -re 's/(download-dir\":\ )([a-z]+)*(.*)/\1\"\/srv\/transmission\",/g' /etc/transmission-daemon/settings.json
	service transmission-daemon start

	echo "[+] Enter the non root user account (default on the Raspberry Pi is 'pi'): "
	read SMBUSER

	echo "[+] Setting up Samba user, enter the password for ${SMBUSER} when prompted"
	smbpasswd -a ${SMBUSER}

	echo "[+] Setting up Samba share"
	mkdir /srv/transmission
	chown debian-transmission /srv/transmission
	chmod -R 0777 /srv/transmission

	echo "[Transmission]
   comment=Transmission downloads folder
   path=/srv/transmission
   writeable=Yes
   create mask=0777
   directory mask=0777
   browsable=Yes
   public=Yes
   valid users=${SMBUSER}" >> /etc/samba/smb.conf

	service samba restart
}

if [ ! $(whoami) = "root" ]; then
        echo "[-] This script must be run as root."
        echo "[-] Run this script again with sudo, eg. 'sudo ./bittorrent_server.sh'"
else
        do_install
fi
