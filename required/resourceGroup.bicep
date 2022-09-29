param resourceGroupName string
param location string
param tags object

targetScope='subscription'

// https://learn.microsoft.com/en-us/azure/templates/microsoft.resources/resourcegroups?pivots=deployment-language-bicep
resource resourceGroupResource 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
  // managedBy: 'string'
  // properties: {}
}
