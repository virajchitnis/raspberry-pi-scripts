Raspberry Pi Scripts
====================

Scripts to setup a Raspberry Pi as a headless server for specific tasks

The Raspberry Pi is a tiny and power efficient computer that can easily hide in your closet. But it is powerful enough to be used as an appliance for simple tasks such as running a BitTorrent server or NAS. The only problem is that setting this up can take a considerable amount of research and time for somebody who is not experienced enough with any variant of Linux or Unix. This is why I have written these simple scripts that can setup the Pi to do those specific tasks.

I have tested these scripts on a Raspberry Pi running the Raspbian OS (A derivative of Debian 7 'Wheezy' built specifically for the Pi). Feel free to use them. If you happen to come across any bugs or issues, please let me know so that I may make the necessary changes or I may allow you to commit changes to this repository.

The scripts and their uses are described below:
	add_samba_share.sh - This script can be used to create a new NAS (samba) share.
	bittorrent_server.sh - Installs the transmission bittorrent client and samba so that you can download torrents and then access them from your PC/Mac/Linux computer via as a NAS.

Note: Technically, these scripts should be usable on any Debian 7 'Wheezy' machine with a few minor modifications, but I have not tested this.

