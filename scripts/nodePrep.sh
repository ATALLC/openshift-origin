#!/bin/bash

echo $(date) " - Starting Script"

echo "START LINKS"
echo "$1"
echo "$2"
echo "$3"
echo "$4"
echo "$5"
echo "$6"
echo "$7"
echo "END LINKS"

COCKPITKUBERNETESIMAGELINK="$1"
OPENSHIFTORIGINDEPLOYERIMAGELINK="$2"
OPENSHIFTORIGINDOCKERREGISTRYIMAGELINK="$3"
OPENSHIFTORIGINHAPROXYIMAGELINK="$4"
OPENSHIFTORIGINPODIMAGELINK="$5"
OPENSHIFTORIGINNODEIMAGELINK="$6"
OPENSHIFTORIGINRPMSLINK="$7"

# Install EPEL repository
echo $(date) " - Installing EPEL"

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

echo $(date) " - EPEL successfully installed"

echo $(date) " - Disabling non Microsoft Yum Repos"

# Disable all non microsoft repos to replicate CCE environment
# sudo yum update -y --disablerepo='*' --enablerepo='*microsoft*'

echo $(date) " - Successfully disabled non Microsoft Yum Repos"

echo $(date) " - Installing Openshift Origin rpms"
mkdir -p /var/lib/waagent/openshift-origin-rpms
wget -O /var/lib/waagent/openshift-origin-rpms/openshift-origin-rpms.tar $OPENSHIFTORIGINRPMSLINK
tar -xvf /var/lib/waagent/openshift-origin-rpms/openshift-origin-rpms.tar -C /var/lib/waagent/openshift-origin-rpms
ls -al /var/lib/waagent/openshift-origin-rpms
yum -y install /var/lib/waagent/openshift-origin-rpms/*.rpm

echo $(date) " - Openshift Origin rpms installed successfully"

# Update system to latest packages and install dependencies
echo $(date) " - Update system to latest packages and install dependencies"

yum repolist all
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
wget -O /tmp/cockpit_kubernetes.docker $COCKPITKUBERNETESIMAGELINK
wget -O /tmp/openshift_origin-deployer.3.9.docker $OPENSHIFTORIGINDEPLOYERIMAGELINK
wget -O /tmp/openshift_origin-docker-registry.3.9.docker $OPENSHIFTORIGINDOCKERREGISTRYIMAGELINK
wget -O /tmp/openshift_origin-haproxy-router.3.9.docker $OPENSHIFTORIGINHAPROXYIMAGELINK
wget -O /tmp/openshift_origin-pod.3.9.docker $OPENSHIFTORIGINPODIMAGELINK
wget -O /tmp/openshift_origin-node.docker $OPENSHIFTORIGINNODEIMAGELINK
echo "Docker files location: "
echo `pwd`
echo `ls -al`

docker load -i /tmp/openshift_origin-pod.3.9.docker
docker load -i /tmp/openshift_origin-docker-registry.3.9.docker
docker load -i /tmp/openshift_origin-deployer.3.9.docker
docker load -i /tmp/openshift_origin-haproxy-router.3.9.docker
docker load -i /tmp/cockpit_kubernetes.docker
docker load -i /tmp/openshift_origin-node.docker

systemctl restart systemd-logind NetworkManager

echo $(date) " - Script Complete"