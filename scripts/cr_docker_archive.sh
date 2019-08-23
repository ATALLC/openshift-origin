#!/bin/bash

echo $(date) " - Starting Script"

docker pull docker.io/openshift/origin-node
docker save -o openshift_origin-node.docker openshift/origin-node

#docker pull docker.io/openshift/origin-control-plane
#docker save -o openshift_origin-control-plane.docker openshift/origin-control-plane

docker pull docker.io/openshift/origin-haproxy-router:v3.9
docker save -o openshift_origin-haproxy-router.3.9.docker openshift/origin-haproxy-router:v3.9

docker pull docker.io/openshift/origin-deployer:v3.9
docker save -o openshift_origin-deployer.3.9.docker openshift/origin-deployer:v3.9

#docker pull docker.io/openshift/origin-template-service-broker
#docker save -o openshift_origin-template-service-broker.docker openshift/origin-template-service-broker

docker pull docker.io/openshift/origin-pod:v3.9
docker save -o openshift_origin-pod.3.9.docker openshift/origin-pod:v3.9

#docker pull docker.io/busybox
#docker save -o busybox.docker busybox

#docker pull docker.io/ansibleplaybookbundle/origin-ansible-service-broker
#docker save -o ansibleplaybookbundle_origin-ansible-service-broker.docker ansibleplaybookbundle/origin-ansible-service-broker

docker pull docker.io/openshift/origin-docker-registry:v3.9
docker save -o openshift_origin-docker-registry.3.9.docker openshift/origin-docker-registry:v3.9

#docker pull docker.io/openshift/origin-console
#docker save -o openshift_origin-console.docker openshift/origin-console

#docker pull docker.io/openshift/origin-service-catalog
#docker save -o openshift_origin-service-catalog.docker openshift/origin-service-catalog

#docker pull docker.io/openshift/origin-web-console
#docker save -o openshift_origin-web-console.docker openshift/origin-web-console

docker pull docker.io/cockpit/kubernetes
docker save -o cockpit_kubernetes.docker cockpit/kubernetes

#docker pull docker.io/openshift/prometheus-alertmanager
#docker save -o openshift_prometheus-alertmanager.docker openshift/prometheus-alertmanager

#docker pull docker.io/openshift/prometheus-node-exporter
#docker save -o openshift_prometheus-node-exporter.docker openshift/prometheus-node-exporter

#docker pull docker.io/openshift/prometheus
#docker save -o openshift_prometheus.docker openshift/prometheus

#docker pull docker.io/grafana/grafana
#docker save -o grafana_grafana.docker grafana/grafana

#docker pull docker.io/openshift/oauth-proxy
#docker save -o openshift_oauth-proxy.docker openshift/oauth-proxy

#docker pull quay.io/coreos/kube-rbac-proxy
#docker save -o coreos_kube-rbac-proxy.docker coreos/kube-rbac-proxy

#docker pull quay.io/coreos/etcd
#docker save -o coreos_etcd.docker coreos/etcd

#docker pull quay.io/coreos/kube-state-metrics
#docker save -o coreos_kube-state-metrics.docker coreos/kube-state-metrics

#docker pull quay.io/coreos/configmap-reload
#docker save -o coreos_configmap-reload.docker coreos/configmap-reload

#docker pull quay.io/coreos/cluster-monitoring-operator
#docker save -o coreos_cluster-monitoring-operator.docker coreos/cluster-monitoring-operator

#docker pull quay.io/coreos/prometheus-config-reloader
#docker save -o coreos_prometheus-config-reloader.docker coreos/prometheus-config-reloader

#docker pull quay.io/coreos/prometheus-operator
#docker save -o coreos_prometheus-operator.docker coreos/prometheus-operator

echo $(date) " - Script Complete"
