// az deployment sub create --template-file createResources.bicep --confirm-with-what-if 
targetScope = 'subscription'

param resourceGroupName string = 'rg-scs-sbx-we-1'
param location string = 'westeurope'
param applicationValue string = 'Small Capacity Synapse'
param environmentValue string = 'Sandbox'
param storageAccountName string = 'sascssbxwe1'
param containerNames array = [
  'data'
  'logging'
  'staging'
]
param workspaceName string = 'synws-scs-sbx-we-1'
param managedResourceGroupName string =  'rg-scs-man-sbx-we-1'

@maxLength(60)
param dedicatedSqlPoolName string = 'syndpscssbxwe1'
@minLength(1)
@maxLength(15)
param sparkPoolName string ='synspscssbxwe1' 
@minLength(4)
@maxLength(22)
param dataExplorerName string ='syndescssbxwe1' 

param createDedicatedSQLPool bool = false
param createApacheSparkPool bool = false
param createDataExplorerPool bool = false

var tags = {
  application: applicationValue
  environment: environmentValue
}

var storageBlobDataContributorRoleId = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'

module resourceGroupModule 'required/resourceGroup.bicep' = {
  name: 'resourceGroupModule'
  scope: subscription()
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

module storageAccountModule 'required/storageAccount.bicep' = {
  name: 'storageAccountModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    storageAccountName: storageAccountName
    tags: tags
    location: location
    containerNames: containerNames
  }
  dependsOn: [ resourceGroupModule ]
}

module workspaceModule 'required/workspace.bicep' = {
  name: 'workspaceModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    storageAccountName: storageAccountName
    workspaceName: workspaceName
    location: location
    tags: tags
    managedResourceGroupName: managedResourceGroupName
    primaryContainer: containerNames[0]
  }
  dependsOn: [ storageAccountModule ]
}

module roleAssignmentModule 'required/roleAssignment.bicep' = {
  name: 'roleAssignmentModule'
  scope:  resourceGroup(resourceGroupName)
  params: {
    storageAccountName: storageAccountName
    principalId: workspaceModule.outputs.principalId
    roleDefinitionID: storageBlobDataContributorRoleId
  }

}
module dedicatedSqlPoolModule 'optional/dedicatedSQLPool.bicep' =  if (createDedicatedSQLPool) {
  name: 'dedicatedSqlPoolModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    workspaceName: workspaceName
    dedicatedSqlPoolName: dedicatedSqlPoolName
    location: location
    tags: tags
  }
  dependsOn: [ workspaceModule ]
}

module apacheSparkPoolModule 'optional/apacheSparkPool.bicep' =  if (createApacheSparkPool) {
  name: 'apacheSparkPoolModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    workspaceName: workspaceName
    sparkPoolName:sparkPoolName
    location: location
    tags: tags
  }
  dependsOn: [ workspaceModule ]
}

module dataExplorerPoolModule 'optional/dataExplorerPool.bicep' =  if (createDataExplorerPool) {
  name: 'dataExplorerPoolModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    workspaceName: workspaceName
    dataExplorerName:dataExplorerName
    location: location
    tags: tags
  }
  dependsOn: [ workspaceModule ]
}
