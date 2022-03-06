param location string = resourceGroup().location

param createContainers bool = true

@description('Podaj nazwę konta storage lub zostaw puste - nazwa zostanie wygenerowana automatycznie')
@minLength(3)
@maxLength(24)
param storageName string = 'stgwsb${uniqueString(resourceGroup().id)}'

var containerNames = [
  'logs'
  'archive'
  'input'
  'done'
  'wsb'
  'emil'
]

resource clientStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
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
}

module blobContainer './blobContainer.bicep' = [for containerName in containerNames: if (createContainers) {
  name: 'create_container_${containerName}'
  params: {
    containerName: toLower(containerName)
    storageName: clientStorage.name
  }
}]
