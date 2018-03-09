all: flash.zip

deploy: flash.zip
	adb push flash.zip /sdcard/freefontpatch_test.zip

flash.zip: META-INF/com/google/android/update-binary META-INF/com/google/android/updater-script 51-freefontpatch.sh FreeSans.ttf FreeSerif.ttf
	zip -r -y -9 flash.zip META-INF 51-freefontpatch.sh FreeSans.ttf FreeSerif.ttf

clean:
	rm -f flash.zip
