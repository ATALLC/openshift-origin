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
echo "$8"
echo "END LINKS"

OPENSHIFTORIGINRPMSLINK="$1"
NODEIMAGESLINK="$2"
INFRA1IMAGESLINK="$3"
INFRA2IMAGESLINK="$4"
INFRA3IMAGESLINK="$5"
INFRALOGGINGIMAGESLINK="$6"
INFRAMETRICSIMAGESLINK="$7"
REGISTRYIMAGELINK="$8"

# Install EPEL repository
echo $(date) " - Installing EPEL"

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

echo $(date) " - EPEL successfully installed"

echo $(date) " - Disabling non Microsoft Yum Repos"

# Disable all non microsoft repos to replicate CCE environment
# sudo yum update -y --disablerepo='*' --enablerepo='*microsoft*'

echo $(date) " - Successfully disabled non Microsoft Yum Repos"

echo $(date) " - Creating Local Openshift Origin Yum Repo"
mkdir -p /var/lib/waagent/openshift-origin-rpms
mkdir -p /var/lib/waagent/openshift-origin-rpms/repo
wget -O /var/lib/waagent/openshift-origin-rpms/openshift-origin-rpms.tar $OPENSHIFTORIGINRPMSLINK
tar -xvf /var/lib/waagent/openshift-origin-rpms/openshift-origin-rpms.tar -C /var/lib/waagent/openshift-origin-rpms/repo
ls -al /var/lib/waagent/openshift-origin-rpms/repo
yum -y install createrepo
createrepo /var/lib/waagent/openshift-origin-rpms/repo

echo $(date) " - Local Openshift Origin Yum Repo created successfully"

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
docker load -i /tmp/node-images.tar
docker load -i /tmp/infra-images1.tar
docker load -i /tmp/infra-images2.tar
docker load -i /tmp/infra-images3.tar
docker load -i /tmp/infra-logging-images.tar
docker load -i /tmp/infra-metrics-images.tar

wget -O /tmp/node-images.tar $NODEIMAGESLINK
wget -O /tmp/infra-images1.tar $INFRA1IMAGESLINK
wget -O /tmp/infra-images2.tar $INFRA2IMAGESLINK
wget -O /tmp/infra-images3.tar $INFRA3IMAGESLINK
wget -O /tmp/infra-logging-images.tar $INFRALOGGINGIMAGESLINK
wget -O /tmp/infra-metrics-images.tar $INFRAMETRICSIMAGESLINK
wget -O /tmp/infra-images1.tar $REGISTRYIMAGELINK

docker load -i /tmp/node-images.tar
docker load -i /tmp/infra-images1.tar
docker load -i /tmp/infra-images2.tar
docker load -i /tmp/infra-images3.tar
docker load -i /tmp/infra-logging-images.tar
docker load -i /tmp/infra-metrics-images.tar
docker load -i /tmp/registry-image.tar

docker run -d -p 5000:5000 --restart=always --name registry registry

docker tag openshift/origin-logging-fluentd:v3.9 localhost:5000/openshift/origin-logging-fluentd:v3.9
docker tag cockpit/kubernetes:latest localhost:5000/cockpit/kubernetes:latest
docker tag openshift/origin-node:latest localhost:5000/openshift/origin-node:latest
docker tag openshift/origin-pod:v3.9.0 localhost:5000/openshift/origin-pod:v3.9.0
docker tag openshift/origin-docker-registry:v3.9.0 localhost:5000/openshift/origin-docker-registry:v3.9.0
docker tag openshift/origin-template-service-broker:v3.9.0 localhost:5000/openshift/origin-template-service-broker:v3.9.0
docker tag ansibleplaybookbundle/origin-ansible-service-broker:v3.9 localhost:5000/ansibleplaybookbundle/origin-ansible-service-broker:v3.9
docker tag openshift/origin-haproxy-router:v3.9.0 localhost:5000/openshift/origin-haproxy-router:v3.9.0
docker tag openshift/origin-deployer:v3.9.0 localhost:5000/openshift/origin-deployer:v3.9.0
docker tag openshift/origin-logging-auth-proxy:v3.9 localhost:5000/openshift/origin-logging-auth-proxy:v3.9
docker tag openshift/origin-logging-curator:v3.9 localhost:5000/openshift/origin-logging-curator:v3.9
docker tag openshift/origin-logging-kibana:v3.9 localhost:5000/openshift/origin-logging-kibana:v3.9
docker tag openshift/origin-metrics-hawkular-metrics:v3.9 localhost:5000/openshift/origin-metrics-hawkular-metrics:v3.9
docker tag openshift/origin-metrics-heapster:v3.9 localhost:5000/openshift/origin-metrics-heapster:v3.9

docker push localhost:5000/openshift/origin-logging-fluentd:v3.9
docker push localhost:5000/cockpit/kubernetes:latest
docker push localhost:5000/openshift/origin-node:latest
docker push localhost:5000/openshift/origin-pod:v3.9.0
docker push localhost:5000/openshift/origin-docker-registry:v3.9.0
docker push localhost:5000/openshift/origin-template-service-broker:v3.9.0
docker push localhost:5000/ansibleplaybookbundle/origin-ansible-service-broker:v3.9
docker push localhost:5000/openshift/origin-haproxy-router:v3.9.0
docker push localhost:5000/openshift/origin-deployer:v3.9.0
docker push localhost:5000/openshift/origin-logging-auth-proxy:v3.9
docker push localhost:5000/openshift/origin-logging-curator:v3.9
docker push localhost:5000/openshift/origin-logging-kibana:v3.9
docker push localhost:5000/openshift/origin-metrics-hawkular-metrics:v3.9
docker push localhost:5000/openshift/origin-metrics-heapster:v3.9

systemctl restart systemd-logind NetworkManager

echo $(date) " - Script Complete"