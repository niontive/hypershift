#!/bin/bash

export CLUSTER_NAME="hypershift"
export RESOURCE_GROUP="hypershift"
export SUBSCRIPTION="0cc1cafa-578f-4fa5-8d6b-ddfd8d82e6ea"
export ACR_NAME="hypershiftacr"
export SP="813ad11e-8e60-4aaf-9771-98625fd19398"
export LOCATION="eastus"


azure_login() {
    echo "Logging into Azure..."
    accountShow=$(az account show)
    if [ -z "$accountShow" ]; then
        az login
    fi
    az account set --subscription "$SUBSCRIPTION"
}