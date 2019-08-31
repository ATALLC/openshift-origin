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
echo "$9"
echo "${10}"
echo "${11}"
echo "END LINKS"

MASTERIMAGESLINK="$1"
NODEIMAGESLINK="$2"
INFRA1IMAGESLINK="$3"
INFRA2IMAGESLINK="$4"
INFRA3IMAGESLINK="$5"
INFRALOGGINGIMAGESLINK="$6"
INFRAMETRICSIMAGESLINK="$7"
REGISTRYIMAGELINK="$8"
CERTLINK="$9"
KEYLINK="${10}"
REGIP="${11}"

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
wget -O /tmp/master-images.tar $MASTERIMAGESLINK
wget -O /tmp/node-images.tar $NODEIMAGESLINK
wget -O /tmp/infra-images1.tar $INFRA1IMAGESLINK
wget -O /tmp/infra-images2.tar $INFRA2IMAGESLINK
wget -O /tmp/infra-images3.tar $INFRA3IMAGESLINK
wget -O /tmp/infra-logging-images.tar $INFRALOGGINGIMAGESLINK
wget -O /tmp/infra-metrics-images.tar $INFRAMETRICSIMAGESLINK
wget -O /tmp/registry-image.tar $REGISTRYIMAGELINK

docker load -i /tmp/master-images.tar
docker load -i /tmp/node-images.tar
docker load -i /tmp/infra-images1.tar
docker load -i /tmp/infra-images2.tar
docker load -i /tmp/infra-images3.tar
docker load -i /tmp/infra-logging-images.tar
docker load -i /tmp/infra-metrics-images.tar
docker load -i /tmp/registry-image.tar

#create private registry
mkdir -p /certs
chcon -Rt svirt_sandbox_file_t /certs/
wget -O /certs/ca.crt $CERTLINK
wget -O /certs/ca.key $KEYLINK
docker run -d -p 443:443 --restart=always --name registry -v /certs:/certs -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/ca.crt -e REGISTRY_HTTP_TLS_KEY=/certs/ca.key -e REGISTRY_HTTP_SECRET= registry

# Trust docker registry
echo "${REGIP} smartfmdockerreg.io" >> /etc/hosts
mkdir -p /etc/docker/certs.d/smartfmdockerreg.io
wget -O /etc/docker/certs.d/smartfmdockerreg.io/ca.crt $CERTLINK
service docker reload

docker tag openshift/origin-web-console:v3.9.0 smartfmdockerreg.io/openshift/origin-web-console:v3.9.0 
docker tag openshift/origin-service-catalog:v3.9.0 smartfmdockerreg.io/openshift/origin-service-catalog:v3.9.0
docker tag openshift/origin-logging-fluentd:v3.9 smartfmdockerreg.io/openshift/origin-logging-fluentd:v3.9
docker tag cockpit/kubernetes:latest smartfmdockerreg.io/cockpit/kubernetes:latest
docker tag openshift/origin-node:latest smartfmdockerreg.io/openshift/origin-node:latest
docker tag openshift/origin-pod:v3.9.0 smartfmdockerreg.io/openshift/origin-pod:v3.9.0
docker tag openshift/origin-docker-registry:v3.9.0 smartfmdockerreg.io/openshift/origin-docker-registry:v3.9.0
docker tag openshift/origin-template-service-broker:v3.9.0 smartfmdockerreg.io/openshift/origin-template-service-broker:v3.9.0
docker tag ansibleplaybookbundle/origin-ansible-service-broker:v3.9 smartfmdockerreg.io/ansibleplaybookbundle/origin-ansible-service-broker:v3.9
docker tag openshift/origin-haproxy-router:v3.9.0 smartfmdockerreg.io/openshift/origin-haproxy-router:v3.9.0
docker tag openshift/origin-deployer:v3.9.0 smartfmdockerreg.io/openshift/origin-deployer:v3.9.0
docker tag openshift/origin-logging-auth-proxy:v3.9 smartfmdockerreg.io/openshift/origin-logging-auth-proxy:v3.9
docker tag openshift/origin-logging-curator:v3.9 smartfmdockerreg.io/openshift/origin-logging-curator:v3.9
docker tag openshift/origin-logging-kibana:v3.9 smartfmdockerreg.io/openshift/origin-logging-kibana:v3.9
docker tag openshift/origin-metrics-hawkular-metrics:v3.9 smartfmdockerreg.io/openshift/origin-metrics-hawkular-metrics:v3.9
docker tag openshift/origin-metrics-heapster:v3.9 smartfmdockerreg.io/openshift/origin-metrics-heapster:v3.9
docker tag openshift/origin-metrics-cassandra:v3.9 smartfmdockerreg.io/openshift/origin-metrics-cassandra:v3.9
docker tag openshift/origin-logging-elasticsearch:v3.9 smartfmdockerreg.io/openshift/origin-logging-elasticsearch:v3.9
docker tag openshift/oauth-proxy:v1.0.0 smartfmdockerreg.io/openshift/oauth-proxy:v1.0.0
docker tag quay.io/coreos/etcd:latest smartfmdockerreg.io/quay.io/coreos/etcd:latest


docker push smartfmdockerreg.io/openshift/origin-web-console:v3.9.0
docker push smartfmdockerreg.io/origin-service-catalog:v3.9.0
docker push smartfmdockerreg.io/openshift/origin-logging-fluentd:v3.9
docker push smartfmdockerreg.io/cockpit/kubernetes:latest
docker push smartfmdockerreg.io/openshift/origin-node:latest
docker push smartfmdockerreg.io/openshift/origin-pod:v3.9.0
docker push smartfmdockerreg.io/openshift/origin-docker-registry:v3.9.0
docker push smartfmdockerreg.io/openshift/origin-template-service-broker:v3.9.0
docker push smartfmdockerreg.io/ansibleplaybookbundle/origin-ansible-service-broker:v3.9
docker push smartfmdockerreg.io/openshift/origin-haproxy-router:v3.9.0
docker push smartfmdockerreg.io/openshift/origin-deployer:v3.9.0
docker push smartfmdockerreg.io/openshift/origin-logging-auth-proxy:v3.9
docker push smartfmdockerreg.io/openshift/origin-logging-curator:v3.9
docker push smartfmdockerreg.io/openshift/origin-logging-kibana:v3.9
docker push smartfmdockerreg.io/openshift/origin-metrics-hawkular-metrics:v3.9
docker push smartfmdockerreg.io/openshift/origin-metrics-heapster:v3.9
docker push smartfmdockerreg.io/openshift/origin-metrics-cassandra:v3.9
docker push smartfmdockerreg.io/openshift/origin-logging-elasticsearch:v3.9
docker push smartfmdockerreg.io/openshift/oauth-proxy:v1.0.0
docker push smartfmdockerreg.io/quay.io/coreos/etcd:latest

echo $(date) " - Script Complete"