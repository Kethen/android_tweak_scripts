#!/sbin/sh
export PATH=/sbin
if [ "$1" = "backup" ]
then
	cp /system/fonts/FreeSans.ttf /tmp/
	cp /system/fonts/FreeSerif.ttf /tmp/
fi
if [ "$1" = "restore" ]
then
	cp /tmp/FreeSans.ttf /system/fonts/
	cp /tmp/FreeSerif.ttf /system/fonts/
	chcon u:object_r:system_file:s0 /system/fonts/FreeSerif.ttf
	chcon u:object_r:system_file:s0 /system/fonts/FreeSans.ttf
	chmod 644 /system/fonts/FreeSans.ttf
	chmod 644 /system/fonts/FreeSerif.ttf
	sed -i '/<\/familyset>/i <family><font weight=\"400\" style=\"normal\">FreeSans.ttf<\/font><\/family><family><font weight=\"400\" style=\"normal\">FreeSerif.ttf<\/font><\/family>' /system/etc/fonts.xml
fi
