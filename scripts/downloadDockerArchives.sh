#!/bin/bash

echo $(date) " - Starting Script"

docker pull docker.io/openshift/origin-metrics-heapster:v3.9
docker pull docker.io/openshift/origin-metrics-hawkular-metrics:v3.9
docker pull docker.io/openshift/origin-metrics-cassandra:v3.9
docker pull docker.io/openshift/origin-logging-kibana:v3.9
docker pull docker.io/openshift/origin-logging-curator:v3.9
docker pull docker.io/openshift/origin-logging-auth-proxy:v3.9
docker pull docker.io/openshift/origin-logging-elasticsearch:v3.9
docker pull docker.io/openshift/origin-node
docker pull docker.io/openshift/origin-haproxy-router:v3.9.0
docker pull docker.io/openshift/origin-deployer:v3.9.0
docker pull docker.io/openshift/origin-template-service-broker:v3.9.0
docker pull docker.io/openshift/oauth-proxy:v1.0.0
docker pull quay.io/coreos/etcd:latest
docker pull docker.io/openshift/origin-pod:v3.9.0
docker pull docker.io/ansibleplaybookbundle/origin-ansible-service-broker:v3.9
docker pull docker.io/openshift/origin-docker-registry:v3.9.0
docker pull docker.io/openshift/origin-service-catalog:v3.9.0
docker pull docker.io/openshift/origin-web-console:v3.9.0
docker pull docker.io/cockpit/kubernetes
docker pull docker.io/openshift/origin-logging-fluentd:v3.9
docker pull docker.io/registry

docker save -o node-images.tar \
docker.io/openshift/origin-logging-fluentd:v3.9 \
docker.io/cockpit/kubernetes:latest \
docker.io/openshift/origin-node:latest \
docker.io/openshift/origin-pod:v3.9.0

docker save -o master-images.tar \
docker.io/openshift/origin-web-console:v3.9.0 \
docker.io/openshift/origin-service-catalog:v3.9.0

docker save -o infra-images1.tar \
docker.io/openshift/origin-docker-registry:v3.9.0 \
docker.io/openshift/origin-template-service-broker:v3.9.0 \
docker.io/ansibleplaybookbundle/origin-ansible-service-broker:v3.9 \
docker.io/openshift/oauth-proxy:v1.0.0 \
quay.io/coreos/etcd:latest

docker save -o infra-images2.tar \
docker.io/openshift/origin-haproxy-router:v3.9.0

docker save -o infra-images3.tar \
docker.io/openshift/origin-deployer:v3.9.0

docker save -o infra-logging-images.tar \
docker.io/openshift/origin-logging-auth-proxy:v3.9 \
docker.io/openshift/origin-logging-curator:v3.9 \
docker.io/openshift/origin-logging-kibana:v3.9 \
docker.io/openshift/origin-logging-elasticsearch:v3.9

docker save -o infra-metrics-images.tar \
docker.io/openshift/origin-metrics-hawkular-metrics:v3.9 \
docker.io/openshift/origin-metrics-heapster:v3.9 \
docker.io/openshift/origin-metrics-cassandra:v3.9

docker save -o registry-image.tar \
registry \

echo $(date) " - Script Complete"
