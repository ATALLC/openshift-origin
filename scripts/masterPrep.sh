#!/bin/bash

echo $(date) " - Starting Script"

STORAGEACCOUNT=$1
SUDOUSER=$2
LOCATION=$3

# Install EPEL repository
echo $(date) " - Installing EPEL"

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

echo $(date) " - EPEL successfully installed"

# Update system to latest packages and install dependencies
echo $(date) " - Update system to latest packages and install dependencies"

yum -y install wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct httpd-tools
yum -y install cloud-utils-growpart.noarch
yum -y update --exclude=WALinuxAgent
systemctl restart dbus

echo $(date) " - System updates successfully installed"

# Only install Ansible and pyOpenSSL on Master-0 Node
# python-passlib needed for metrics
echo $(date) " - Install Ansible on the master node"

if hostname -f|grep -- "-0" >/dev/null
then
    echo $(date) " - Installing Ansible"
    ### ADD THE COMMANDS TO COPY THE RPMS ###
    #COPY the RPMS to /tmp/ansible-rpms/
    wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/ansible-2.6.2-1.el7.ans.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/libyaml-0.1.4-11.el7_0.x86_64.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-babel-0.9.6-8.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-backports-1.0-8.el7.x86_64.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-cffi-1.6.0-5.el7.x86_64.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-enum34-1.0.4-1.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-idna-2.4-1.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-ipaddress-1.0.16-2.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-jinja2-2.7.2-3.el7_6.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-markupsafe-0.11-10.el7.x86_64.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-paramiko-2.1.1-9.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-ply-3.4-11.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-pycparser-2.14-1.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-setuptools-0.9.8-7.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python-six-1.9.0-2.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python2-cryptography-1.7.2-2.el7.x86_64.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/python2-pyasn1-0.1.9-7.el7.noarch.rpm
	  wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/PyYAML-3.10-11.el7.x86_64.rpm
    wget -P /tmp/ansible-rpms/ https://raw.githubusercontent.com/ATALLC/openshift-origin/existing-network-3.9/ansible-rpms/sshpass-1.06-2.el7.x86_64.rpm
	  yum -y install /tmp/ansible-rpms/*.rpm
fi

echo $(date) " - Ansible installed successfully"

if hostname -f|grep -- "-0" >/dev/null
then
    echo $(date) " - Installing pyOpenSSL and python-passlib"
    yum -y --enablerepo=epel install pyOpenSSL python-passlib
	#yum -y install https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.2-1.el7.ans.noarch.rpm
fi

echo $(date) " - pyOpenSSL and python-passlib installed successfully"

# Install java to support metrics
echo $(date) " - Installing Java"

yum -y install java-1.8.0-openjdk-headless

echo $(date) " - Java installed successfully"

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

DOCKERVG=$( parted -m /dev/sda print all 2>/dev/null | grep unknown | grep /dev/sd | cut -d':' -f1 )

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

# Create Storage Class yml files on MASTER-0

if hostname -f|grep -- "-0" >/dev/null
then
cat <<EOF > /home/${SUDOUSER}/scunmanaged.yml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: generic
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: kubernetes.io/azure-disk
parameters:
  location: ${LOCATION}
  storageAccount: ${STORAGEACCOUNT}
EOF

cat <<EOF > /home/${SUDOUSER}/scmanaged.yml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: generic
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: kubernetes.io/azure-disk
parameters:
  kind: managed
  location: ${LOCATION}
  storageaccounttype: Premium_LRS
EOF

fi

### Copy the zip archive to /tmp/image_archive

# cd /tmp/image_archive
docker load -i openshift_origin-pod.docker
docker load -i openshift_origin-docker-registry.docker
docker load -i openshift_origin-deployer.docker
docker load -i openshift_origin-haproxy-router.docker
docker load -i cockpit_kubernetes.docker
docker load -i openshift_origin-node.docker

echo $(date) " - Script Complete"
