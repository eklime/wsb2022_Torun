
@description('Podaj nazwę konta storage')
@minLength(3)
@maxLength(23)
param stgName string

param location string = resourceGroup().location

var StorageName = toLower(stgName)

resource storageAccount_res 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: StorageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    publicNetworkAccess: 'Disabled'
    allowSharedKeyAccess: true
    supportsHttpsTrafficOnly: true
    routingPreference: {
      routingChoice: 'MicrosoftRouting'
    }
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

output storageName object = storageAccount_res.properties.primaryEndpoints
