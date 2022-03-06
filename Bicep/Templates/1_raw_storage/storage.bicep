param location string = resourceGroup().location
param createdOn string = utcNow()

@description('Podaj nazwę konta storage lub zostaw puste - nazwa zostanie wygenerowana automatycznie')
@minLength(3)
@maxLength(24)
param storageName string = 'wsbstg1${uniqueString(resourceGroup().id)}'

resource clientStorage 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: toLower(storageName)
  location: location
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
    accessTier: 'Hot'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
    }
  }
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    'Created': createdOn
  }
}

output storageNameOT string = clientStorage.name
// az deployment group create -g wsb-main -f ./1_raw_storage/storage.bicep -n 1_storage
