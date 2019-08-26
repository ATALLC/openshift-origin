#!/bin/bash

echo $(date) " - Starting Script"
mkdir -p $1/openshift-origin-rpms
wget -O $1/openshift-origin-rpms/origin-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-clients-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-clients-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-clients-redistributable-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-clients-redistributable-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-cluster-capacity-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-cluster-capacity-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-docker-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-docker-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm"
wget -O $1/openshift-origin-rpms/origin-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm"
wget -O $1/openshift-origin-rpms/origin-federation-services-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-federation-services-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-master-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-master-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-node-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-node-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-pod-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-pod-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-sdn-ovs-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-sdn-ovs-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-service-catalog-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-service-catalog-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-template-service-broker-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-template-service-broker-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"
wget -O $1/openshift-origin-rpms/origin-tests-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-tests-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm"

echo $(date) " - Script Complete"
