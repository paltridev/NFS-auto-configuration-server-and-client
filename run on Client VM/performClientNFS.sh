#!/bin/bash

echo "


       ********************************************
       *  NFS CLIENT SIDE CONFIGURATION BY TRIDEV *
       *                                          *
       ********************************************
"

yum install -y nfs-utils #install utilities

if [ -d /mnt/nfsshare ]  #create directory for nfsshare in mnt
then
	echo "" 
	echo "folder exist"
else
	mkdir /mnt/nfsshare
	echo ""
	echo "Folder created"
fi

echo ""
echo "Enter IP of Server(Do ifconfig in server virtual machine,paste it here, and press enter )"
read ipServer

echo ""
echo "mounting nfs folder from server"
mount -t nfs $ipServer:/var/nfsshare /mnt/nfsshare
echo "mounted"
echo " "
echo " "
echo "Test mount with 'mount |grep nfs' and create a file in folder nfsshare to see if it's working"

echo "


       ********************************************
       *  NFS CLIENT SIDE CONFIGURATION DONE      *
       *                                          *
       ********************************************
"
