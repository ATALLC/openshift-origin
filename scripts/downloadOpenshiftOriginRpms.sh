#!/bin/bash

echo $(date) " - Starting Script"
mkdir -p $1/openshift-origin-rpms
wget -O $1/openshift-origin-rpms/origin-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-clients-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-clients-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-docker-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-docker-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm"
wget -O $1/openshift-origin-rpms/origin-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm"
wget -O $1/openshift-origin-rpms/origin-master-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-master-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-node-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-node-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-sdn-ovs-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-sdn-ovs-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/openvswitch-2.6.1-3.git20161206.el7.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/common/openvswitch-2.6.1-3.git20161206.el7.x86_64.rpm"
echo $(date) " - Script Complete"
