param storageAccountName string
param workspaceName string
param location string
param tags object
param primaryContainer string
param managedResourceGroupName string

resource storageAccountResource 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageAccountName
}

resource workspaceResource 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      accountUrl: storageAccountResource.properties.primaryEndpoints.dfs
      filesystem: primaryContainer
    }
    managedResourceGroupName: managedResourceGroupName
    // publicNetworkAccess: 'Disabled' // Bicep error: You can only set Public Network Access to "Disabled" for Synapse workspace associated with managed VNet

  }
}

var firewallRules = [
  {  name: 'allowAll' 
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }
]

resource firewallRulesResource 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = [for rule in firewallRules: {
  name: rule.name
  properties: rule.properties
  parent: workspaceResource
}]

output principalId string = workspaceResource.identity.principalId
