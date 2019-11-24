#!/bin/bash

echo "


       ********************************************
       *  NFS SERVER SIDE CONFIGURATION BY TRIDEV *
       *                                          *
       ********************************************
"

yum install -y nfs-utils #install utilities

if [ -d /var/nfsshare ]  #create directory for nfsshare in var
then
	echo "" 
	echo "folder exist"
else
	mkdir /var/nfsshare
	echo ""
	echo "Folder created"
fi

chmod 777 /var/nfsshare #give permission to folder

systemctl enable rpcbind

echo "rpc enabled"

systemctl enable nfs-server

echo "nfs-server enabled"

systemctl enable nfs-lock

echo "nfs-lock enabled"

systemctl enable nfs-idmap

echo "nfs-idmap enabled"

systemctl start rpcbind

echo "rpc started"

systemctl start nfs-server

echo "nfs-server started"

systemctl start nfs-lock

echo "nfs-lock started"

systemctl start nfs-idmap
echo "nfs-idmap started"


echo ""
echo "Enter IP of client (Do ifconfig in client virtual machine,paste it here, and press enter )"
read ipClient

echo "/var/nfsshare    $ipClient(rw,sync,no_root_squash,no_all_squash)" > /etc/exports
echo ""
echo "IP client has been input in exports file"
echo ""

systemctl restart nfs-server
echo "nfs-server restarted"
echo ""

echo "adding firewall permissions to allow nfs-server through firewall"
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind

echo ""
echo "Restarting firewall"
firewall-cmd --reload
echo "firewall restarted"


echo "


       ********************************************
       *  NFS SERVER SIDE CONFIGURATION DONE      *
       *                                          *
       ********************************************
"



