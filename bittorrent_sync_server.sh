#!/bin/sh

# Note: This script must be run as root.

# Script to build a Raspberry Pi BitTorrent Sync server.
# After running this script, you can visit http://<ip of your pi>:8888 to use BitTorrent Sync.
# If you wish to modify any settings such as enabling a user and password for the BitTorrent Sync web interface, you need to modify the /opt/btsync/btsync.config file.
# 	If you are doing it as a normal user, you will need to do 'sudo nano /opt/btsync/btsync.config'.
#	If you are doing it as root, then skip the 'sudo' keyword.

start_up_script () {
	echo "[+] Creating system service for BitTorrent Sync Server"
	echo "#!/bin/sh
# /etc/init.d/btsync
#

case "$1" in
        start)
                echo "Starting BitTorrent Sync Server"
                cd /opt/btsync
                ./btsync --config btsync.config
                ;;
        restart)
                echo "Stopping BitTorrent Sync Server"
                PID=$(pidof btsync)
                kill -9 ${PID}
                echo "Starting BitTorrent Sync Server"
                cd /opt/btsync
                ./btsync --config btsync.config
                ;;
        stop)
                echo "Stopping BitTorrent Sync Server"
                PID=$(pidof btsync)
                kill -9 ${PID}
                ;;
        *)
        	echo "Usage: service btsync {start|restart|stop}"
                echo "Usage: /etc/init.d/btsync {start|restart|stop}"
                exit 1
                ;;
esac

exit 0" >> /etc/init.d/btsync

	chmod +x /etc/init.d/btsync
	update-rc.d btsync defaults
}

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
	
	start_up_script
	
	echo "[+] Starting BitTorrent Sync Server"
	service btsync start

	echo "[+] Cleaning up"
	rm btsync_arm.tar.gz
}

if [ ! $(whoami) = "root" ]; then
        echo "[-] This script must be run as root."
        echo "[-] Run this script again with sudo, eg. 'sudo ./bittorrent_sync_server.sh'"
else
        do_install
fi
