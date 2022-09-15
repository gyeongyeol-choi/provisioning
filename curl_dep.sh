# Mac Address
MAC=ifconfig -a eno1 | grep 'ether' | cut -f10 -d" "

# IP Address
IP=ifconfig -a eno1 | grep 'inet ' | cut -f10 -d" "

# Service Call
curl -X POST http://192.168.8.31:8080/TmaxLinuxMaster/TmaxLinuxMaster/Machine?action=Notify -d '{"dto":{"machineMac": "$MAC", "machineIP": "$IP", "machineStatus": 3}}'
