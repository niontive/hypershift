#!/bin/bash

pull_secret="pull-secret.txt"
credentials="credentials.txt"
node_selector="hypershift.poc=node"
cluster_name="aks-test"

# Image 4.13.12-x86_64
release_image="quay.io/openshift-release-dev/ocp-release@sha256:73946971c03b43a0dc6f7b0946b26a177c2f3c9d37105441315b4e3359373a55"

./bin/hypershift create cluster azure --release-image "$release_image" \
                                      --base-domain "$DNS_ZONE_NAME" \
                                      --pull-secret "$pull_secret" \
                                      --name "$cluster_name" \
                                      --azure-creds "$credentials" \
                                      --node-selector "$node_selector" \
                                      --generate-ssh               