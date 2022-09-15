# This script is used for setting IPMI Server. (It valids in Ubuntu 16.04, Ubuntu 17.10, and TmaxLinux)

# 1. Install ipmitool
sudo apt-get install ipmitool

# 2. Apply IPMI Module
modprobe ipmi_devintf
modprobe ipmi_si
modprobe ipmi_msghandler

lsmod | grep ipmi
