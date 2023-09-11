#!/bin/bash

# Environment
BICEP_FILE="main.bicep"
LOCATION="eastus"
RESOURCE_GROUP="hypershift"
SUBSCRIPTION="0cc1cafa-578f-4fa5-8d6b-ddfd8d82e6ea"

create_deployment() {
    echo "Deploying bicep file $BICEP_FILE..."
    az deployment group create --resource-group "$RESOURCE_GROUP" --template-file "$BICEP_FILE"
}

create_resource_group() {
    echo "Creating resource group..."
    az group create --name $RESOURCE_GROUP --location $LOCATION
}

azure_login() {
    echo "Logging into Azure..."
    accountShow=$(az account show)
    if [ -z "$accountShow" ]; then
        az login
    fi
    az account set --subscription "$SUBSCRIPTION"
}

# Begin script execution
azure_login
create_resource_group
create_deployment