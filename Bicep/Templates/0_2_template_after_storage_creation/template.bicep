param storageAccounts_wsbstgsadsdfresf_name string = 'wsbstgsadsdfresf'

resource storageAccounts_wsbstgsadsdfresf_name_resource 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccounts_wsbstgsadsdfresf_name
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
   
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    isHnsEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_wsbstgsadsdfresf_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageAccounts_wsbstgsadsdfresf_name_resource
  name: 'default'
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_wsbstgsadsdfresf_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-06-01' = {
  parent: storageAccounts_wsbstgsadsdfresf_name_resource
  name: 'default'

  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_wsbstgsadsdfresf_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-06-01' = {
  parent: storageAccounts_wsbstgsadsdfresf_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_wsbstgsadsdfresf_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-06-01' = {
  parent: storageAccounts_wsbstgsadsdfresf_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}
