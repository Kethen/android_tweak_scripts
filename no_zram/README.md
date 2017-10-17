This is a script and initrc combo for diabling zram on lineageos 14.2. It was designed to persist after system updates using addon.d. There's this license document there but the goal of putting this here is for everyone to reference or use directly.

To build the package simply
	make
	or
	zip -r no_zram.zip system META-INF

When to try this tweak out:

1. If your device gets unresponsive after some usage since turning on.
2. If your device gets very unresponsive after waking up from a deep sleep. This tweak might be able to improve responsiveness during background sync.

**this is very device dependent, on an old samsung tablet with only 1GB of ram and slow cpu, disabling zram makes the full facebook app usable, contarary to complete unresponsiveness and timeouts**

**on faster devices however, you might want to keep zram on to multitask better**


On non lineageos devices:

This might still work as long as your os adopts extra rc files inside /etc/init in the system partition. If not, you can checkout the very simple main script system/etc/nozram.sh. Try to bootstrap it or something similar for your OS through different techniques.


Brief description of zram:

Zram in linux is a way to trade cpu performance for more memory space. To be more technical, it is a dynamic sized swap partition, compressed and stored in ram. In some cases it could provide great multitasking experience, expecially when devices has good cpu power and fast memory. However, on devices with not too good cpu performance, it could make devices unresponsive when memory is near full. The reason for the unresponsiveness is that the kernel needs to try hard to swap in and out memory from compressed swap and ram, with very limited free space in ram.


Zram and Android memory management:

For some Android devices and apps, allowing Android to perform the standard activity life cycle (https://developer.android.com/guide/components/images/activity_lifecycle.png) could actually be more responsive as swapping with zram and a slower processer could cause system wide unresponsiveness, while Android itself takes system UI responsiveness seriously, memory management with app pausing, killing in the background is usually hard to be noticed by user. Further more, most apps take advantage of the onStop() procedure to restore app state after being killed by system memory management then reopened by user, so the multi tasking experience and responsiveness depends on whether swapping with zram takes more time, can an app restore it's own state and which procedure takes more time.

