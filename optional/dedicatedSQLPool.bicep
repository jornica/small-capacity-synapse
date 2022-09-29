param workspaceName string
param dedicatedSqlPoolName string
param location string
param tags object

var sku = 'DW100c'

resource workspaceResource 'Microsoft.Synapse/workspaces@2021-06-01' existing = {
  name: workspaceName
}
// https://learn.microsoft.com/en-us/azure/templates/microsoft.synapse/2021-06-01/workspaces/sqlpools?pivots=deployment-language-bicep
resource dedicatedSqlPoolResource 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' = {
  name: dedicatedSqlPoolName
  location: location
  tags: tags
  sku: {
    // capacity: int
    name: sku
    // tier: 'string'
  }
  parent: workspaceResource
  properties: {
    // collation: 'string'
    // createMode: 'string'
    // maxSizeBytes: int
    // provisioningState: 'string'
    // recoverableDatabaseId: 'string'
    // restorePointInTime: 'string'
    // sourceDatabaseDeletionDate: 'string'
    // sourceDatabaseId: 'string'
    storageAccountType: 'LRS'
  }
}

//https://learn.microsoft.com/en-us/azure/templates/microsoft.synapse/workspaces/sqlpools/geobackuppolicies?pivots=deployment-language-bicep
resource geoBackupPoliciesResource 'Microsoft.Synapse/workspaces/sqlPools/geoBackupPolicies@2021-06-01' = {
  name: 'Default'
  parent: dedicatedSqlPoolResource
  properties: {
    state: 'Disabled'
  }
}
