#!/sbin/sh
export PATH=/sbin
FONTS_FOLDER=/system/fonts
FONTS="emojione-android.ttf"
XML="/system/etc/fonts.xml"
if [ "$1" = "backup" ]
then
	for f in $FONTS
	do
		cp $FONTS_FOLDER/$f /tmp/
	done
fi
if [ "$1" = "restore" ]
then
	for f in $FONTS
	do
		cp /tmp/$f $FONTS_FOLDER
		chcon u:object_r:system_file:s0 $FONTS_FOLDER/$f
		chmod 644 $FONTS_FOLDER/$f
		sed -i "/<font weight=\"400\" style=\"normal\">NotoColorEmoji.ttf<\/font>/i <font weight=\"400\" style=\"normal\">$f<\/font>" $XML
	done
fi
