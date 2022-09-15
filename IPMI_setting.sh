# This script is for IPMI Setting in the specific node.
#!/bin/bash

# 1. Network Setting
ipmitool lan print 1
ipmitool lan set 1 ipsrc static
ipmitool lan set 1 ipaddr 192.168.1.212
ipmitool lan set 1 netmask 255.255.255.0
ipmitool lan set 1 defgw ipaddr 192.168.1.1
ipmitool lan set 1 access on

# 2. User Setting
ipmitool user list 1
ipmitool user set password 2
