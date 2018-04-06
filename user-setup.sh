#!/bin/bash
# Script for setting up software development environment for a specific user.

# Get the absolute path of this script on the system.
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# RC server partition that will be used for RAMCloud backups.
RCXX_BACKUP_DIR=$1

# Checkout TorcDB, RAMCloud, and related repositories
echo -e "\n===== CLONING REPOSITORIES ====="
git clone https://github.com/PlatformLab/RAMCloud.git

# Compile and configure RAMCloud
echo -e "\n===== COMPILE AND CONFIGURE RAMCLOUD ====="
cd RAMCloud
git submodule update --init --recursive
ln -s ../../hooks/pre-commit .git/hooks/pre-commit

# Build DPDK libraries
mkdir private
cat >>private/MakefragPrivateTop <<EOL
DEBUG := no

CCACHE := yes
LINKER := gold
DEBUG_OPT := yes

GLIBCXX_USE_CXX11_ABI := yes

DPDK := yes
DPDK_DIR := dpdk
DPDK_SHARED := no
EOL
MLNX_DPDK=y scripts/dpdkBuild.sh

make -j8

# Construct localconfig.py for this cluster setup.
cd $HOME/RAMCloud/scripts
> localconfig.py

# Set the backup file location
echo "default_disk = '-f $RCXX_BACKUP_DIR/backup.log'" >> localconfig.py

# Construct localconfig hosts array
echo -e "\n===== SETUP RAMCLOUD LOCALCONFIG.PY ====="
while read -r ip hostname alias1 alias2 alias3
do 
  if [[ $hostname =~ ^rc[0-9]+-rclan$ ]] 
  then
    rcnames=("${rcnames[@]}" "$hostname") 
  fi 
done < /etc/hosts
IFS=$'\n' rcnames=($(sort <<<"${rcnames[*]}"))
unset IFS

echo -n "hosts = [" >> localconfig.py
for i in $(seq ${#rcnames[@]})
do
  hostname=${rcnames[$(( i - 1 ))]}
  ipaddress=`ssh $hostname "hostname -i"`
  tuplestr="(\"$hostname\", \"$ipaddress\", $i)"
  if [[ $i == ${#rcnames[@]} ]]
  then
    echo "$tuplestr]" >> localconfig.py
  else 
    echo -n "$tuplestr, " >> localconfig.py
  fi
done

echo -e "\n===== USER SETUP COMPLETE ====="

