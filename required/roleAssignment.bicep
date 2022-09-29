param storageAccountName string
param principalId string
param roleDefinitionID string

resource storageAccountResource 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageAccountName
}

var roleAssignmentName= guid(principalId, roleDefinitionID, storageAccountResource.id)

//https://learn.microsoft.com/en-us/azure/templates/microsoft.authorization/roleassignments?pivots=deployment-language-bicep
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentName
  scope: storageAccountResource
  properties: {
    // condition: 'string'
    // conditionVersion: 'string'
    // delegatedManagedIdentityResourceId: 'string'
    // description: 'string'
    principalId: principalId
    // principalType: 'string'
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionID)
  }
}
