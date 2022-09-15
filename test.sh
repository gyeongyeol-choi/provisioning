#!/bin/bash

read -e -p "Your IP : " YOUR_IP
echo "<$YOUR_IP>을 입력하였습니다."
read -e -p "SUBNET : " SUBNET
echo "<$SUBNET>을 입력하였습니다."

echo "option arch code 93 = unsigned integer 16; # RFC4578
allow booting;
allow bootp;

subnet $SUBNET netmask 255.255.255.0 {
range $START_IP $END_IP;
option broadcast-address $BROADCAST_IP;
option routers $GATEWAY_IP;
option domain-name-servers 168.126.63.1;
next-server $SERVER_IP;
ddns-updates off;
if option arch = 00:07 { # Boot Mode: UEFI
	filename "grubnetx64.efi.signed";
}
												else { # Boot Mode: Legacy
													filename "pxelinux.0";
												}
											}"
