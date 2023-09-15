@description('The name of the Managed Cluster resource.')
param clusterName string = 'hypershiftCluster'

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 3

@description('The size of the system Virtual Machine.')
param systemVMSize string = 'standard_d2s_v3'

@description('The size of the HCP vm')
param hcpVMSize string = 'Standard_D32ads_v5'

@description('The name of the Azure Container Registry.')
param acrName string = 'hypershiftacr'

@description('ACR pull role ID')
var acrPullRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions/', '7f951dda-4ed3-4680-a7ca-43fe172d538d')

@description('DNS zone name')
var dnsZoneName = 'hypershift.azurequickstart.org'

resource aks 'Microsoft.ContainerService/managedClusters@2023-06-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: clusterName
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: systemVMSize
        osType: 'Linux'
        mode: 'System'
      }
      {
        name: 'hcp'
        osDiskSizeGB: osDiskSizeGB
        count: 1
        vmSize: hcpVMSize
        osType: 'Linux'
        mode: 'User'
        nodeLabels: {
          'hypershift.poc': 'node'
        }
      }
    ]
  }
}

resource acr 'Microsoft.ContainerRegistry/registries@2023-06-01-preview' = {
  name: acrName
  location: location
  sku: { 
    name: 'Standard'
  }
}

resource acrRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(clusterName, acrName)
  scope: acr
  properties: {
    principalId: aks.properties.identityProfile.kubeletidentity.objectId
    roleDefinitionId: acrPullRoleId
  }
}

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: dnsZoneName
  location: 'global'
  properties: {
    zoneType: 'Public'
  }
}
