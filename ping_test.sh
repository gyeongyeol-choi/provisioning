# This is the script to find the available IP in the subnet.
#!/bin/bash
Subnet=1
fping -g 192.168.$Subnet.0/24
