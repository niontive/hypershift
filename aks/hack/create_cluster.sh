#!/bin/bash

pull_secret="pull-secret.txt"
credentials="credentials.txt"
base_domain="hypershift.azurequickstart.org"
control_plane_image="hypershiftacr.azurecr.io/control-plane-operator:latest"

# Image 4.13.12-x86_64
release_image="quay.io/openshift-release-dev/ocp-release@sha256:73946971c03b43a0dc6f7b0946b26a177c2f3c9d37105441315b4e3359373a55"

cluster_name="$1"

./bin/hypershift create cluster azure --control-plane-operator-image "$control_plane_image" \
                                      --release-image "$release_image" \
                                      --base-domain "$base_domain" \
                                      --pull-secret "$pull_secret" \
                                      --name "$cluster_name" \
                                      --azure-creds "$credentials" \
                                      --node-selector "hypershift=niontive" \
                                      --generate-ssh               