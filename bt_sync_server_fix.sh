#!/bin/sh

run_btsync () {
	if [ -d /opt/btsync ]; then
		cd /opt/btsync
		
		if [ -d .sync ] && [ -f btsync.config ] && [ -f btsync ]; then
			./btsync --config btsync.config
		else
			echo "[-] Please run 'bittorrent_sync_server.sh' before running this script"
			echo "[-] If you did run that script before running this one but are still receiving this message, it means that the 'bittorrent_sync_server.sh' script did not run properly"
		fi
	else
		echo "[-] Please run 'bittorrent_sync_server.sh' before running this script"
		echo "[-] If you did run that script before running this one but are still receiving this message, it means that the 'bittorrent_sync_server.sh' script did not run properly"
	fi
}

if [ ! $(whoami) = "root" ]; then
        echo "[-] This script must be run as root."
        echo "[-] Run this script again with sudo, eg. 'sudo ./bittorrent_serve$
else
        run_btsync
fi
