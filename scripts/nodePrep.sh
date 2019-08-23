#!/bin/bash

echo $(date) " - Starting Script"

echo "START LINKS"
echo "$1"
echo "$2"
echo "$3"
echo "$4"
echo "$5"
echo "$6"
echo "END LINKS"

COCKPITKUBERNETESIMAGELINK="$1"
OPENSHIFTORIGINDEPLOYERIMAGELINK="$2"
OPENSHIFTORIGINDOCKERREGISTRYIMAGELINK="$3"
OPENSHIFTORIGINHAPROXYIMAGELINK="$4"
OPENSHIFTORIGINPODIMAGELINK="$5"
OPENSHIFTORIGINNODEIMAGELINK="$6"

# Install EPEL repository
echo $(date) " - Installing EPEL"

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

echo $(date) " - EPEL successfully installed"

# Update system to latest packages and install dependencies
echo $(date) " - Update system to latest packages and install dependencies"

yum -y install wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
yum -y install cloud-utils-growpart.noarch
yum -y update --exclude=WALinuxAgent
systemctl restart dbus

echo $(date) " - System updates successfully installed"

# Grow Root File System
echo $(date) " - Grow Root FS"

rootdev=`findmnt --target / -o SOURCE -n`
rootdrivename=`lsblk -no pkname $rootdev`
rootdrive="/dev/"$rootdrivename
name=`lsblk  $rootdev -o NAME | tail -1`
part_number=${name#*${rootdrivename}}

growpart $rootdrive $part_number -u on
xfs_growfs $rootdev

if [ $? -eq 0 ]
then
    echo $(date) " - Root File System successfully extended"
else
    echo $(date) " - Root File System failed to be grown"
	exit 20
fi

# Install Docker 1.13.x
echo $(date) " - Installing Docker 1.13.x"

yum -y install docker
sed -i -e "s#^OPTIONS='--selinux-enabled'#OPTIONS='--selinux-enabled --insecure-registry 172.30.0.0/16'#" /etc/sysconfig/docker

echo $(date) " - Docker installed successfully"

# Create thin pool logical volume for Docker
echo $(date) " - Creating thin pool logical volume for Docker and staring service"

DOCKERVG=$( parted -m /dev/sda print all 2>/dev/null | grep unknown | grep /dev/sd | cut -d':' -f1  | awk 'NR==1' )

echo "DEVS=${DOCKERVG}" >> /etc/sysconfig/docker-storage-setup
echo "VG=docker-vg" >> /etc/sysconfig/docker-storage-setup
docker-storage-setup
if [ $? -eq 0 ]
then
    echo "Docker thin pool logical volume created successfully"
else
    echo "Error creating logical volume for Docker"
    exit 5
fi

# Enable and start Docker services

systemctl enable docker
systemctl start docker

### Copy docker images down to load
wget $COCKPITKUBERNETESIMAGELINK
wget $OPENSHIFTORIGINDEPLOYERIMAGELINK
wget $OPENSHIFTORIGINDOCKERREGISTRYIMAGELINK
wget $OPENSHIFTORIGINHAPROXYIMAGELINK
wget $OPENSHIFTORIGINPODIMAGELINK
wget $OPENSHIFTORIGINNODEIMAGELINK
echo "Docker files location: "
echo `pwd`
echo `ls -al`

docker load -i openshift_origin-pod.docker
docker load -i openshift_origin-docker-registry.docker
docker load -i openshift_origin-deployer.docker
docker load -i openshift_origin-haproxy-router.docker
docker load -i cockpit_kubernetes.docker
docker load -i openshift_origin-node.docker

echo $(date) " - Script Complete"
