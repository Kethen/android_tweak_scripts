#!/system/bin/sh
# written by Katharine Chui in 2017
# https://github.com/Kethen
PATH=/system/bin:/system/xbin:/system/sbin
#wait for /data to mount
#while [ "$(mount | grep /data)" = "" ]
#do
#sleep 5
#done

#LAN_OUT="p2p0"

#while [ true ]
#do

#echo flusu and policies
#iptables -t filter -X
#iptables -t nat -X
#iptables -t filter -F
#iptables -t nat -F
#iptables -t filter -P INPUT DROP
#iptables -t filter -P FORWARD DROP
#iptables -t filter -P OUTPUT DROP

#iptables -t filter -A INPUT -m state --state established,related -j ACCEPT
#iptables -t filter -A INPUT -i lo -j ACCEPT

#echo NAT
#for i in $LAN_OUT
#do
#	iptables -t nat -A POSTROUTING -o $i -j MASQUERADE
#	iptables -t filter -A FORWARD -o $i -j ACCEPT
#done
#echo 1 > /proc/sys/net/ipv4/ip_forward
#iptables -t filter -A FORWARD -m state --state established,related -j ACCEPT


echo app blacklist
#check previous settings
if [ -f /data/appNetBlacklist_last ]
then
	for app in $(cat /data/appNetBlacklist_last)
	do
		UID=$(cat /data/system/packages.xml | grep $app | sed -n 's/.*userId="\([0-9]*\)".*/\1/p')
		if [ "$UID" != "" ]
		then
			iptables -t filter -D OUTPUT -m owner --uid-owner $UID -j DROP
		fi
	done
fi
#create default blacklist
if [ ! -f /data/appNetBlacklist ]
then
	echo cn.wps.moffice_eng > /data/appNetBlacklist 
fi
#save previous settings
cp /data/appNetBlacklist /data/appNetBlacklist_last
#apply blacklist
for app in $(cat /data/appNetBlacklist)
do
	UID=$(cat /data/system/packages.xml | grep $app | sed -n 's/.*userId="\([0-9]*\)".*/\1/p')
	if [ "$UID" != "" ]
	then
		iptables -t filter -I OUTPUT -m owner --uid-owner $UID -j DROP
	fi
done
#echo accepted output
#iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 993 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 587 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 465 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --match multiport --dports 5228:5230 -j ACCEPT

#echo accepted input
#iptables -t filter -A INPUT -p udp --sport 123 -j ACCEPT

echo setting nameserver
#using iptables to redirect all DNS requests to a nameserver, no matter what are the dhcp settings

#undo last time's settings
if [ -f /data/nameserver_last ]; then
	iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT --to-destination $(cat /data/nameserver_last):53
	rm /data/nameserver_last
fi


#first, check if 'nameserver' file is in /data. If not, create an empty one
#to use custom DNS, fill in make a text file /data/nameserver storing a single IP eg. echo '8.8.8.8' > /data/nameserver
if [ ! -f /data/nameserver ]; then
	touch /data/nameserver
fi

#check if the nameserver file is empty. If not empty apply the procedures to enable redirection
if [ "$(cat /data/nameserver)" != "" ]; then
	#save the collected ip
	cp /data/nameserver /data/nameserver_last

	#change resolv.conf for glibc binaries
	echo 'nameserver '$(cat /data/nameserver) > /data/resolv.conf

	#read nameserver address from file and then apply it
	iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination $(cat /data/nameserver):53
fi

echo running firewall script /data/firewall.sh
if [ ! -f /data/firewall.sh ]
then
	echo "#iptables -t filter -P OUTPUT ACCEPT" > /data/firewall.sh
fi
/system/bin/sh /data/firewall.sh

#sleep 180
#done
