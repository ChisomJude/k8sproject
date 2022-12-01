#!/usr/bin/env bash

CLUSTER="K8sCapstoneProject"
REGION="us-west-1"
CLUSTER_NAME="${CLUSTER}.${REGION}.eksctl.io"

if kubectl config get-clusters | grep -q ${CLUSTER_NAME}; then
    echo
    echo "Cluster '${CLUSTER_NAME}' already exists!"
    echo
else
    echo
    echo "Creating cluster..."
    ./bash/eksctl create cluster --config-file=mycluster.yml
fi
