This repository stores scripts that I have written for my Android devices.


freefontfallback_patch adds regular freesans and freeserif at the very end of the system font family as to catch all unicode characters that cannot be display by default system fonts

no_zram adds an init script on the system partition which un-swaps zram swap for devices with enough ram but weaker processor to prevent unresponsiveness due to swapping

android_firewall contains a script which allows you to block certain applications from accessing the internet by specifying package name, as well as redirecting all your DNS traffic to DNS server that you desire to based on configuration files placed in /data/
