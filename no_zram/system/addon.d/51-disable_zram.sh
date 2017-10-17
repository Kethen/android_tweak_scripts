#!/sbin/sh
PATH=/sbin
if [ "$1" = "backup" ]
then
	cp -a /system/etc/init/nozram.rc /tmp/
	cp -a /system/etc/nozram.sh /tmp/
fi

if [ "$1" = "restore" ]
then
	cp -a /tmp/nozram.rc /system/etc/init/
	cp -a /tmp/nozram.sh /system/etc/
fi

if [ "$1" != "restore" ] && [ "$1" != "backup" ]
then
	echo go away
fi