Raspberry Pi Scripts
====================

Scripts to setup a Raspberry Pi as a headless server for specific tasks

The Raspberry Pi is a tiny and power efficient computer that can easily hide in your closet. But it is powerful enough to be used as an appliance for simple tasks such as running a BitTorrent server or NAS (Network Attached Storage). The only problem is that setting this up can take a considerable amount of research and time for somebody who is not experienced enough with any variant of Linux or Unix. This is why I have written these simple scripts that can setup the Pi to do those specific tasks.

I have tested these scripts on a Raspberry Pi running the Raspbian OS (A derivative of Debian 7 'Wheezy' built specifically for the Pi). Feel free to use them. If you happen to come across any bugs or issues, please let me know so that I may make the necessary changes or I may allow you to commit changes to this repository.

To use these scripts, you can either clone the repository to your Pi or simply open the script and copy its text into a text editor. If you choose to use the later approach, you need to save the copied text as file with a '.sh' extension, make it executable and run it. If you choose to clone the git repository, you can just simply run the scripts as they are.

If you dont know how to clone a git repository, open script you wish to use, the browser window should show you a text editor with the content of the script in it. Copy all the text. Open a text editor, TextEdit (Mac), Notepad (Windows), Gedit (Linux) or nano (Linux) and paste the text into it. Save the file as '<scipt name>.sh'. Copy the file to your Pi (Use either scp/ssh or sftp to achieve this. Run 'chmod +x <name of script>.sh' to make it executable. Run 'sudo ./<name of script>.sh' to run the script. If you are unable to follow these directions, you can simply perform a search in your favorite search engine on how to run a shell script in linux.

The scripts and their uses are described below:

add_samba_share.sh - Creates a new NAS (samba) share.

bittorrent_server.sh - Installs the transmission bittorrent client and samba so that you can download torrents and then access them from your PC/Mac/Linux computer via NAS.

bittorrent_sync_server.sh - Installs BitTorrent Sync so that you can sync files between computers. You will need to have BitTorrent Sync clients for your PC/Mac as well to be able to use this. For more info about BitTorrent Sync, visit http://www.bittorrent.com/sync

If you need a script for any specific task, feel free to send in your request, I will try to provide a script for your requested task, but can give no guarantee on whether or not and how soon I will be able to do so.

Note: Technically, these scripts should be usable on any Debian 7 'Wheezy' machine with a few minor modifications, but I have not tested this.
