#curl -X POST http://192.168.8.31:8080/TmaxLinuxMaster/TmaxLinuxMaster/Node?action=Get -d '{"dto":{"nodeIP": "192.168.8.50"}}'
# 1. CPU
echo "### CPU MODEL ###"
cpuModel=`cat /proc/cpuinfo | grep 'model name' | head -n 1 | cut -f2 -d":"` # Model Name
echo "cpu model : "$cpuModel
echo "### CPU CNT ###"
cpuCnt=`grep -c processor /proc/cpuinfo` # Core Count
echo "cpu count : "$cpuCnt

# 2. Memory
echo "### MEMORY SIZE ###"
memSize=`cat /proc/meminfo | grep MemTotal | cut -f2 -d":"` # Memory Size (KB)
echo "memory size: "$memSize

# 3. Disk
echo "### DISK TEST ###"
diskInfo=`lsblk -b -o NAME,TYPE,SIZE,SERIAL | grep 'disk'`
echo "disk info: "$diskInfo

Log=$cpuModel"+"$cpuCnt"+"$memSize"+"$diskInfo
echo $Log

# Mac Address
#MAC=`ifconfig -a enp0s3 | grep 'ether' | cut -f10 -d" "`

# IP Address
#IP=`ifconfig -a enp0s3 | grep 'inet ' | cut -f10 -d" "`

# Service Call
curl -X POST http://192.168.8.31:8080/TmaxLinuxMaster/TmaxLinuxMaster/Machine?action=Notify -d '{"dto":{"machineMac": "$MAC", "machineIP": "$IP", "machineStatus": 4, "machineLog": "$Log"}}'
