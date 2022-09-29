param workspaceName string
param sparkPoolName string
param location string
param tags object

resource workspaceResource 'Microsoft.Synapse/workspaces@2021-06-01' existing = {
  name: workspaceName
}

// https://learn.microsoft.com/en-us/azure/templates/microsoft.synapse/workspaces/bigdatapools?pivots=deployment-language-bicep
resource apacheSparkPoolResource 'Microsoft.Synapse/workspaces/bigDataPools@2021-06-01' = {
  name: sparkPoolName
  location: location
  tags: tags
  parent: workspaceResource
  properties: {
    autoPause: {
      delayInMinutes: 15
      enabled: true
    }
    autoScale: {
      enabled: false
      maxNodeCount: 0
      minNodeCount: 0
    }
    cacheSize: 50
    // customLibraries: [
    //   {
    //     containerName: 'string'
    //     name: 'string'
    //     path: 'string'
    //     type: 'string'
    //     uploadedTimestamp: 'string'
    //   }
    // ]
    // defaultSparkLogFolder: 'string'
    dynamicExecutorAllocation: {
      enabled: true
      maxExecutors: 2
      minExecutors: 1
    }
    isAutotuneEnabled: true
    isComputeIsolationEnabled: false
    // libraryRequirements: {
    //   content: 'string'
    //   filename: 'string'
    // }
    nodeCount: 3
    nodeSize: 'Small'
    nodeSizeFamily: 'MemoryOptimized'
    // provisioningState: 'string'
    sessionLevelPackagesEnabled: true
    // sparkConfigProperties: {
    //   configurationType: 'string'
    //   content: 'string'
    //   filename: 'string'
    // }
    // sparkEventsFolder: 'string'
    sparkVersion: '3.2'
  }
}
