#!/bin/bash

CRDS_DIR="./aks/API"
YAML_FILE="aks.yaml"
HYPERSHIFT_IMAGE="$ACR_NAME.azurecr.io/hypershift-operator:latest"

# Begin script execution
kubectl create -f "$CRDS_DIR"

./bin/hypershift install \
    --enable-conversion-webhook=false \
    --enable-defaulting-webhook=false \
    --hypershift-image="$HYPERSHIFT_IMAGE" \
    render > $YAML_FILE

kubectl create -f $YAML_FILE