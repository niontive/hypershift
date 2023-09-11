#!/bin/bash

# Environment
BICEP_FILE="main.bicep"
LOCATION="eastus"

create_deployment() {
    echo "Deploying bicep file $BICEP_FILE..."
    az deployment group create \
        --resource-group "$RESOURCE_GROUP" \
        --template-file "$BICEP_FILE" \
        --parameters clusterName="$CLUSTER_NAME" acrName="$ACR_NAME"
}

create_resource_group() {
    echo "Creating resource group..."
    az group create --name $RESOURCE_GROUP --location $LOCATION
}

# Begin script execution
. ../env.sh

azure_login
create_resource_group
create_deployment