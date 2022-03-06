param location string = resourceGroup().location
param storageAccountName string
param accountType string
param kind string
param accessTier string
param minimumTlsVersion string
param supportsHttpsTrafficOnly bool
param allowBlobPublicAccess bool
param allowSharedKeyAccess bool
param allowCrossTenantReplication bool
param defaultOAuth bool
param networkAclsBypass string
param networkAclsDefaultAction string
param isHnsEnabled bool
param isSftpEnabled bool
param isBlobSoftDeleteEnabled bool
param blobSoftDeleteRetentionDays int
param isContainerSoftDeleteEnabled bool
param containerSoftDeleteRetentionDays int
param isShareSoftDeleteEnabled bool
param shareSoftDeleteRetentionDays int

resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: allowBlobPublicAccess
    allowSharedKeyAccess: allowSharedKeyAccess
    allowCrossTenantReplication: allowCrossTenantReplication
    defaultToOAuthAuthentication: defaultOAuth
    networkAcls: {
      bypass: networkAclsBypass
      defaultAction: networkAclsDefaultAction
      ipRules: []
    }
    isHnsEnabled: isHnsEnabled
    isSftpEnabled: isSftpEnabled
  }
  sku: {
    name: accountType
  }
  kind: kind
  tags: {}
  dependsOn: []
}

resource storageAccountName_default 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storageAccountName_resource
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: isBlobSoftDeleteEnabled
      days: blobSoftDeleteRetentionDays
    }
    containerDeleteRetentionPolicy: {
      enabled: isContainerSoftDeleteEnabled
      days: containerSoftDeleteRetentionDays
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileservices_storageAccountName_default 'Microsoft.Storage/storageAccounts/fileservices@2021-08-01' = {
  parent: storageAccountName_resource
  name: 'default'
  properties: {
    shareDeleteRetentionPolicy: {
      enabled: isShareSoftDeleteEnabled
      days: shareSoftDeleteRetentionDays
    }
  }
  dependsOn: [
    storageAccountName_default
  ]
}
