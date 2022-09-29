param workspaceName string
param dataExplorerName string
param location string 
param tags object

resource workspaceResource 'Microsoft.Synapse/workspaces@2021-06-01'  existing = {
  name: workspaceName
}

// https://learn.microsoft.com/en-us/azure/templates/microsoft.synapse/workspaces/kustopools?pivots=deployment-language-bicep
resource symbolicname 'Microsoft.Synapse/workspaces/kustoPools@2021-06-01-preview' = {
  name: dataExplorerName
  location: location
  tags: tags
  sku: {
    capacity: 2
    name: 'Compute optimized'
    size: 'Extra small'
  }
  parent: workspaceResource
  properties: {
    enablePurge: false
    enableStreamingIngest: false
    // optimizedAutoscale: {
    //   isEnabled: bool
    //   maximum: int
    //   minimum: int
    //   version: int
    // }
    workspaceUID:  workspaceResource.properties.workspaceUID
  }
}
