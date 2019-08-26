#!/bin/bash

echo $(date) " - Starting Script"


cd /tmp
mkdir openshift-origin-rpms 
cd /tmp/openshift-origin-rpms

curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-clients-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-clients-redistributable-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-cluster-capacity-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-docker-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-excluder-3.9.0-1.el7.git.0.ba7faec.noarch.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-federation-services-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-master-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-node-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-pod-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-sdn-ovs-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-service-catalog-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-template-service-broker-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm
curl -v -O http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/origin-tests-3.9.0-1.el7.git.0.ba7faec.x86_64.rpm

echo $(date) " - Script Complete"
