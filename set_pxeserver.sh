# This script is used for setting PXE Server. (It valids in Ubuntu 16.04, Ubuntu 17.10, and TmaxLinux)

# 1. Installing Related Packages (must install webtob previously)
sudo apt-get install tftpd-hpa inetutils-inetd isc-dhcp-server fping

# 2. Configuring TFTP Server
echo 'RUN_DAEMON="yes"' >> /etc/default/tftpd-hpa
echo 'OPTIONS="-l -s /var/lib/tftpboot"' >> /etc/default/tftpd-hpa
echo 'tftp    dgram   udp    wait    root    /usr/sbin/in.tftpd /usr/sbin/in.tftpd -s /var/lib/tftpboot' >> /etc/inetd.conf

systemctl restart tftpd-hpa
systemctl status tftpd-hpa

# 3. Copying Boot images to PXE Server (Bootloader, Kernel, Initial Ramdisk)
grep -rl \[WEBTOB_IP\] ./ | xargs sed -i 's/\[WEBTOB_IP\]/[YOUR_IP]/g'
grep -rl \[WEBTOB_PORT\] ./ | xargs sed -i 's/\[WEBTOB_PORT\]/[YOUR_PORT]/g'
grep -rl \[TFTP_IP\] ./ | xargs sed -i 's/\[TFTP_IP\]/[YOUR_IP]/g'
cp -fr tftpboot/* /var/lib/tftpboot/

# 4. Configuring DHCP Server (change the IP, DNS, etc to the vars)
echo 'option arch code 93 = unsigned integer 16; # RFC4578
allow booting;
allow bootp;

subnet [SUBNET] netmask 255.255.255.0 {
	range [START_IP] [END_IP];
	option broadcast-address [BROADCAST_IP];
	option routers [GATEWAY_IP];
	option domain-name-servers 168.126.63.1;
	next-server [YOUR_IP];
	ddns-updates off;
	if option arch = 00:07 { # Boot Mode: UEFI
		filename "grubnetx64.efi.signed";
	}
	else { # Boot Mode: Legacy
		filename "pxelinux.0";
	}
}' >> /etc/dhcp/dhcpd.conf

echo 'INTERFACESv4="[MAC_INTERFACE]"' > /etc/default/isc-dhcp-server

systemctl restart isc-dhcp-server
systemctl status isc-dhcp-server
