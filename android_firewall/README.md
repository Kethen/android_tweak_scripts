A simple iptable script android firewall flashable, mainly for forcing DNS server for cellular networks(current implementation forces DNS on WiFi conenction too) and blocking certain apps from sending any outputs hence potato that app's network capability. This was made before I realise that lineageos or Android Nougat in general can ground apps and disconnect them from the internet but it was still a fun learning experience poking with android init files as well as discovering playing around with modern android recovery's addon.d feature.

If you're flashing it please note that this was only tested on lineageos 14.1 with su addon.

If you're only interested in the script which is rather universal, check /system/etc/firewall.sh on this repository.

Features(/system/etc/firewall.sh):

Block apps from accessing the internet by providing a list of package name in /data/appNetBlacklist_last. As an example by default if the list file does not exist it will create a file that blocks the English/international version of wps office's outgoing traffic.

Forces DNS server by redirecting all udp port 53 traffic to ip address stored in /data/nameserver. If a file is not provided, it will create one as an example with google DNS 8.8.8.8.


Packaging for installation with custom android recoveries:

	make

For other devices, I suggest that you just change the method of launching firewall.sh, such as /system/etc/init.d, if your firmware supports running scripts there with privilege, or any user/group selinux context combination that allows you to run iptables and read-write /data. Of course you can modify that too.
