#!/system/bin/sh
# written by Katharine Chui in 2017
# https://github.com/Kethen

# block until zram is mounted
PATH=/system/bin
COUNT=0
while [ "$(cat /proc/swaps | grep zram)" = "" ] && [ "$COUNT" -lt "60" ]
do
	sleep 5
	COUNT=$(expr $COUNT + 1)
done
swapoff /dev/block/zram*
