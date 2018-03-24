all: flash.zip

deploy: flash.zip
	adb push flash.zip /sdcard/emojionepatch_test.zip

flash.zip: META-INF/com/google/android/update-binary META-INF/com/google/android/updater-script 51-emojionepatch.sh emojione-android.ttf
	zip -r -y -9 flash.zip META-INF 51-emojionepatch.sh emojione-android.ttf

clean:
	rm -f flash.zip
