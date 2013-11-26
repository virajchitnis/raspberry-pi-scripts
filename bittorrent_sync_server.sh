#!/bin/sh

# Note: This script must be run as root.

# Script to build a Raspberry Pi BitTorrent Sync server.
# After running this script, you can visit http://<ip of your pi>:8888 to use BitTorrent Sync.
# If you wish to modify any settings such as enabling a user and password for the BitTorrent Sync web interface, you need to modify the /opt/btsync/btsync.config file.
# 	If you are doing it as a normal user, you will need to do 'sudo nano /opt/btsync/btsync.config'.
#	If you are doing it as root, then skip the 'sudo' keyword.

do_install () {
	echo "[+] Creating install directory"
	mkdir /opt/btsync
	cd /opt/btsync

	echo "[+] Downloading BitTorrent Sync for ARM devices"
	wget http://btsync.s3-website-us-east-1.amazonaws.com/btsync_arm.tar.gz
	echo "[+] Unpacking"
	tar -zxf btsync_arm.tar.gz

	echo "[+] Installing"
	./btsync --dump-sample-config > btsync.config

	echo "[+] Choose an username that will be used to login to the web interface"
	echo "[+] Enter username: "
	read USER

	echo "[+] Choose a password that will be used to login to the web interface"
	echo "[+] Enter password: "
	read PASS

	sed -i -re 's/(\"storage_path\" :\ )([a-z]+)*(.*)/\1\"\/opt\/btsync\/.sync\",/g' btsync.config
	sed -i -re 's/(\"login\" :\ )([a-z]+)*(.*)/\1\"'${USER}'\",/g' btsync.config
	sed -i -re 's/(\"password\" :\ )([a-z]+)*(.*)/\1\"'${PASS}'\"/g' btsync.config

	mkdir .sync
	
	echo "[+] Starting BitTorrent Sync Server"
	./btsync --config btsync.config

	echo "[+] Cleaning up"
	rm btsync_arm.tar.gz
}

if [ ! $(whoami) = "root" ]; then
        echo "[-] This script must be run as root."
        echo "[-] Run this script again with sudo, eg. 'sudo ./bittorrent_sync_server.sh'"
else
        do_install
fi
