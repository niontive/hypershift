#!/bin/bash
FULL_ACR_NAME="$ACR_NAME.azurecr.io"
DOCKERTAG_HYPERSHIFT_OPERATOR="$FULL_ACR_NAME/hypershift-operator"
DOCKERFILE_HYPERSHIFT_OPERATOR="aks.hypershift-operator.Dockerfile"
DOCKERTAG_HYPERSHIFT_CONTROL_PLANE="$FULL_ACR_NAME/control-plane-operator"
DOCKERFILE_HYPERSHIFT_CONTROL_PLANE="aks.hypershift-control-plane.Dockerfile"

acr_login() {
    echo "Logging into ACR..."
    az acr login --name "$FULL_ACR_NAME"
}

push_hypershift_operator() {
    echo "Pushing hypershift-operator image..."
    docker push "$DOCKERTAG_HYPERSHIFT_OPERATOR:latest"
}

build_hypershift_operator() {
    echo "Building hypershift-operator image..."
    docker build -t "$DOCKERTAG_HYPERSHIFT_OPERATOR" -f "$DOCKERFILE_HYPERSHIFT_OPERATOR" .
}

push_hypershift_control_plane() {
    echo "Pushing hypershift-control-plane image..."
    docker push "$DOCKERTAG_HYPERSHIFT_CONTROL_PLANE:latest"
}

build_hypershift_control_plane() {
    echo "Building hypershift-control-plane image..."
    docker build -t "$DOCKERTAG_HYPERSHIFT_CONTROL_PLANE" -f "$DOCKERFILE_HYPERSHIFT_CONTROL_PLANE" .
}

# Begin script execution
acr_login
build_hypershift_operator
push_hypershift_operator
build_hypershift_control_plane
push_hypershift_control_plane