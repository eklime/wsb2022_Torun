param location string = resourceGroup().location
param createContainer bool = true
param createShare bool = true
param containerName string = ''
param shareName string = ''

@description('Podaj nazwę konta storage lub zostaw puste - nazwa zostanie wygenerowana automatycznie')
@minLength(3)
@maxLength(24)
param storageName string = 'stgwsb${uniqueString(resourceGroup().id)}'

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
      defaultAction: 'Deny'
      bypass: 'None'
      virtualNetworkRules: []
      ipRules: []
    }
  }
  sku: {
    name: 'Standard_LRS'
  }
}

module blobContainer './blobContainer.bicep' = if (createContainer == true) {
  name: 'create_container_${containerName}'
  params: {
    containerName: toLower(containerName)
    storageName: clientStorage.name

  }
}

resource fileService_resource 'Microsoft.Storage/storageAccounts/fileServices@2021-06-01' = {
  parent: clientStorage
  name: 'default'
  properties: {
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 14
    }
  }
}

module fileShare './fileShare.bicep' = if (createShare == true) {
  name: 'create_fileShare_${shareName}'
  params: {
    shareName: toLower(shareName)
    storageName: clientStorage.name
  }
  dependsOn: [
    fileService_resource
  ]
}

// az deployment group create -g wsb-main -f ./2_storage_with_share_and_container/storage.bicep -n 2_storage --parameters containerName=wsbcontainer shareName=wsbShare storageName=wsbstg2sharecontainer
