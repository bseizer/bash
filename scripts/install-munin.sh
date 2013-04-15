#!/bin/bash
source /root/scripts/.progress
source /root/scripts/setup-env.sh
echo " Welcome to automated Munin installation script"
prog 10
echo " This script will let you install Munin server and client applications Interactively"
echo " Starting the script now .."
prog 10
location(){
echo " Setup Local Munin instance ( server & client) or a Remote Munin client node ?  "
echo " local | remote"
read locat_install

if [ $locat_install != local ] && [ $locat_install != remote ]
    then
         echo "wrong choice"
         prog 4
         location
elif [ $locat_install == "local" ]
    then
         install_munin
fi
}
install_munin()
{
         setup_env
         ## Installing Munin client and server instance on this server
         yum -y install munin munin-node
}
location
 
