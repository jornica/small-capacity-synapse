param storageAccountName string
param location string
param tags object
param containerNames array

// https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-bicep
resource storageAccountResource 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  // extendedLocation: {
  //   name: 'string'
  //   type: 'EdgeZone'
  // }
  identity: {
    type: 'SystemAssigned'
    //userAssignedIdentities: {}
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    // allowCrossTenantReplication: bool
    // allowedCopyScope: 'string'
    // allowSharedKeyAccess: bool
    // azureFilesIdentityBasedAuthentication: {
    //   activeDirectoryProperties: {
    //     accountType: 'string'
    //     azureStorageSid: 'string'
    //     domainGuid: 'string'
    //     domainName: 'string'
    //     domainSid: 'string'
    //     forestName: 'string'
    //     netBiosDomainName: 'string'
    //     samAccountName: 'string'
    //   }
    //   defaultSharePermission: 'string'
    //   directoryServiceOptions: 'string'
    // }
    // customDomain: {
    //   name: 'string'
    //   useSubDomainName: bool
    // }
    // defaultToOAuthAuthentication: bool
    // dnsEndpointType: 'string'
    // encryption: {
    //   identity: {
    //     federatedIdentityClientId: 'string'
    //     userAssignedIdentity: 'string'
    //   }
    //   keySource: 'string'
    //   keyvaultproperties: {
    //     keyname: 'string'
    //     keyvaulturi: 'string'
    //     keyversion: 'string'
    //   }
    //   requireInfrastructureEncryption: bool
    //   services: {
    //     blob: {
    //       enabled: bool
    //       keyType: 'string'
    //     }
    //     file: {
    //       enabled: bool
    //       keyType: 'string'
    //     }
    //     queue: {
    //       enabled: bool
    //       keyType: 'string'
    //     }
    //     table: {
    //       enabled: bool
    //       keyType: 'string'
    //     }
    //   }
    // }
    // immutableStorageWithVersioning: {
    //   enabled: bool
    //   immutabilityPolicy: {
    //     allowProtectedAppendWrites: bool
    //     immutabilityPeriodSinceCreationInDays: int
    //     state: 'string'
    //   }
    // }
    isHnsEnabled: true
    // isLocalUserEnabled: bool
    // isNfsV3Enabled: bool
    // isSftpEnabled: bool
    // keyPolicy: {
    //   keyExpirationPeriodInDays: int
    // }
    // largeFileSharesState: 'string'
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      // ipRules: [
      //   {
      //     action: 'Allow'
      //     value: ipAddress
      //   }
      // ]
      // resourceAccessRules: [
      //   {
      //     resourceId: 'string'
      //     tenantId: 'string'
      //   }
      // ]
      virtualNetworkRules: [
        // {
        //   action: 'Allow'
        //   id: 'string'
        //   state: 'string'
        // }
      ]
    }
    publicNetworkAccess: 'Enabled'
    // routingPreference: {
    //   publishInternetEndpoints: bool
    //   publishMicrosoftEndpoints: bool
    //   routingChoice: 'string'
    // }
    // sasPolicy: {
    //   expirationAction: 'Log'
    //   sasExpirationPeriod: 'string'
    // }
    supportsHttpsTrafficOnly: true
  }
}

// https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/blobservices?pivots=deployment-language-bicep
resource blobServiceResource 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  name: 'default'
  parent: storageAccountResource
  // properties: {
  //   automaticSnapshotPolicyEnabled: bool
  //   changeFeed: {
  //     enabled: bool
  //     retentionInDays: int
  //   }
  //   containerDeleteRetentionPolicy: {
  //     allowPermanentDelete: bool
  //     days: int
  //     enabled: bool
  //   }
  //   cors: {
  //     corsRules: [
  //       {
  //         allowedHeaders: [
  //           'string'
  //         ]
  //         allowedMethods: [
  //           'string'
  //         ]
  //         allowedOrigins: [
  //           'string'
  //         ]
  //         exposedHeaders: [
  //           'string'
  //         ]
  //         maxAgeInSeconds: int
  //       }
  //     ]
  //   }
  //   defaultServiceVersion: 'string'
  //   deleteRetentionPolicy: {
  //     allowPermanentDelete: bool
  //     days: int
  //     enabled: bool
  //   }
  //   isVersioningEnabled: bool
  //   lastAccessTimeTrackingPolicy: {
  //     blobType: [
  //       'string'
  //     ]
  //     enable: bool
  //     name: 'AccessTimeTracking'
  //     trackingGranularityInDays: int
  //   }
  //   restorePolicy: {
  //     days: int
  //     enabled: bool
  //   }
  // }
}

// https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/blobservices/containers?pivots=deployment-language-bicep
resource containerResource 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = [for name in containerNames: {
  name: name
  parent: blobServiceResource
  properties: {
    // defaultEncryptionScope: 'string'
    // denyEncryptionScopeOverride: bool
    // enableNfsV3AllSquash: bool
    // enableNfsV3RootSquash: bool
    // immutableStorageWithVersioning: {
    //   enabled: bool
    // }
    // metadata: {}

    publicAccess: 'None'
  }
}]
