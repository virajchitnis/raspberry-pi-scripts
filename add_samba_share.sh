#!/bin/sh

# Note: This script must be run as root.

# Create a new samba share.
# After creating a share by running this script, you can connect to it using a samba client.
# The location of this share will be 'smb://<ip of your pi>/<share name>' or '\\<ip of your pi>\<share name>' for Windows OSs.

do_add_share () {
	echo "[+] Update system? [y/n]: "
        read UPDATE
        if [ ${UPDATE} = "y" ]; then
                echo "[+] Updating System"
                apt-get update
                apt-get -y dist-upgrade
        fi

        echo "[+] Installing Samba if it does not exist"
        apt-get -y install samba samba-common-bin

	USERS=""

	echo "[+] Enter the directory to create Samba share on: "
	read DIR

	echo "[+] Enter the name of the share: "
	read SHARE

	echo "[+] Description for the share, not longer than 2-3 words: "
	read COMMENT

	echo "[+] You will be continuously prompted to enter users until you enter -1"
	echo "[+] Enter a user: "
	read USER
	while [ ! ${USER} = "-1" ]; do
		smbpasswd -a ${USER}
		USERS="${USERS} ${USER}"
		echo "[+] Enter another user: "
		read USER
	done

	if [ ! -d ${DIR} ]; then
		mkdir -p ${DIR}
	fi

	echo "[+] Registering Share with Samba"
	echo "[${SHARE}]
        comment = ${COMMENT}
        path = ${DIR}
        read only = no
        guest ok = no
        valid users = ${USERS}
        force user = root" >> /etc/samba/smb.conf
}

if [ ! $(whoami) = "root" ]; then
        echo "[-] This script must be run as root."
        echo "[-] Run this script again with sudo, eg. 'sudo ./bittorrent_server.sh'"
else
        do_add_share
fi

