Raspberry Pi Scripts
====================

Scripts to setup a Raspberry Pi as a headless server for specific tasks

The Raspberry Pi is a tiny and power efficient computer that can easily hide in your closet. But it is powerful enough to be used as an appliance for simple tasks such as running a BitTorrent server or NAS (Network Attached Storage). The only problem is that setting this up can take a considerable amount of research and time for somebody who is not experienced enough with any variant of Linux or Unix. This is why I have written these simple scripts that can setup the Pi to do those specific tasks.

I have tested these scripts on a Raspberry Pi running the Raspbian OS (A derivative of Debian 7 'Wheezy' built specifically for the Pi). Feel free to use them. If you happen to come across any bugs or issues, please let me know so that I may make the necessary changes or I may allow you to commit changes to this repository.

To use these scripts, you can either clone the repository or download a zip file, unzip it and run the script you want.

The scripts and their uses are described below:

bittorrent_server.sh - Installs the transmission bittorrent client and samba so that you can download torrents and then access them from your PC/Mac/Linux computer via NAS.

bittorrent_sync_server.sh - Installs BitTorrent Sync so that you can sync files between computers. You will need to have BitTorrent Sync clients for your PC/Mac as well to be able to use this. For more info about BitTorrent Sync, visit http://www.bittorrent.com/sync

nas_server.sh - Creates a new NAS (samba) share or adds to an existing one.

If you need a script for any specific task, feel free to send in your request, I will try to provide a script for your requested task, but can give no guarantee on whether or not and how soon I will be able to do so.

Note: Technically, these scripts should be usable on any Debian 7 'Wheezy' machine with a few minor modifications, but I have not tested this.
