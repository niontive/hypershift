#!/bin/bash

# Hypershift setup, inspired by: https://hypershift-docs.netlify.app/getting-started/

check_command() {
    echo "Checking for $1..."
    if ! command -v $1 &> /dev/null
    then
        echo "$1 not found. Please install $1 and try again."
        exit 1
    fi
}

download_kubeconfig() {
    echo "Downloading kubeconfig..."
    az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --admin
}

# Begin script execution
. ../env.sh

check_command "oc"
check_command "kubectl"
download_kubeconfig