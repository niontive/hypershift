#!/bin/bash

ACR_NAME="hypershiftacr.azurecr.io"
DOCKERTAG_HYPERSHIFT_OPERATOR="$ACR_NAME/hypershift-operator"
DOCKERFILE_HYPERSHIFT_OPERATOR="aks.hypershift-operator.Dockerfile"

acr_login() {
    echo "Logging into ACR..."
    az acr login --name "$ACR_NAME"
}

push_hypershift_operator() {
    echo "Pushing hypershift-operator image..."
    docker push "$DOCKERTAG_HYPERSHIFT_OPERATOR:latest"
}

build_hypershift_operator() {
    echo "Building hypershift-operator image..."
    docker build -t "$DOCKERTAG_HYPERSHIFT_OPERATOR" -f "$DOCKERFILE_HYPERSHIFT_OPERATOR" .
}

# Begin script execution
acr_login
build_hypershift_operator
push_hypershift_operator