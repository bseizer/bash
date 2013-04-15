#!/bin/bash
source /root/scripts/.progress
##script to check the system and install the pre-requisites required for munin
centosrelease=`cat /etc/centos-release|awk '{print $3}'`
##converting major relase number
centosrelease=${centosrelease/\.*}
##function to install wget
get_wget(){
 echo " Wget not found on this system , trying to install"
 prog 10
     yum install -y wget
     if [ $? -ne 0 ]
        then
            prog 10
            echo "wget installation failed .. pls install wget and run this script again"
            exit 0
     fi
 }
## function to install epel repo
get_epel(){
 
  if [ $centosrelease -eq 5 ]
     then
         url=http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
  elif [ $centosrelease -eq 6 ]
     then
         url=http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
     fi
 echo "Now checking the epel repo url's .."
 prog 5 
 wget --spider $url > /dev/null 2>&1
  if [ $? -ne 0 ]
     then
         echo "Download url for epel release "$centosrelease" is broken , please download and install the epel "$centosrelease" repo rpm on your machine"
         exit 0
  else
         yum install  -y $url
         prog 10
  fi
}
get_apache(){
## function to check and install apache web server
echo "Checking for any installed instances of apache webserver ..."
prog 10
##checking any apache rpms installed on this machine
rpm -qa |grep httpd > /dev/null 2>&1
apa-tem=$?
##checking for apache startup script in std localtion
/etc/init.d/httpd status > /dev/null 2>&1
apa-tem2=$?
##checking for any processes listening on 80 port on the avilable interfaces
}



setup_env() {
##Checking whether wget is installed
which wget > /dev/null 2>&1
if [ $? -ne 0 ]
  then 
      get_wget
      setup_env
else
    get_epel
fi
}
