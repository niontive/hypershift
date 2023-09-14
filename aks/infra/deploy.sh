#!/bin/bash

# Environment
BICEP_FILE="main.bicep"
LOCATION="eastus"
SP="813ad11e-8e60-4aaf-9771-98625fd19398"
CONTRIBUTOR_ROLE="b24988ac-6180-42a0-ab88-20f7382dd24c"
RBAC_ROLE="f58310d9-a9f6-439a-9e8d-f62e7b41a168"

create_deployment() {
    echo "Deploying bicep file $BICEP_FILE..."
    az deployment group create \
        --resource-group "$RESOURCE_GROUP" \
        --template-file "$BICEP_FILE" \
        --parameters clusterName="$CLUSTER_NAME" acrName="$ACR_NAME"

    echo "Deploy bicep file calico.bicep..."
    az deployment group create \
        --resource-group "$RESOURCE_GROUP" \
        --template-file "calico.bicep" \
        --parameters clusterName="hypershiftCalicoCluster" acrName="$ACR_NAME"

}

create_resource_group() {
    echo "Creating resource group..."
    az group create --name $RESOURCE_GROUP --location $LOCATION
}

sp_permissions() {
    az role assignment create --role "$CONTRIBUTOR_ROLE" \
                            --assignee "$SP" \
                            --scope "/subscriptions/$SUBSCRIPTION"

    az role assignment create --role "$RBAC_ROLE" \
                            --assignee "$SP" \
                            --scope "/subscriptions/$SUBSCRIPTION"
}

# Begin script execution
. ../env.sh

azure_login
create_resource_group
create_deployment
sp_permissions