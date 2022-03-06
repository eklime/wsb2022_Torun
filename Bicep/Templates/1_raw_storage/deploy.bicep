
@minLength(3)
@maxLength(24)
param storageName string = 'wsbstg1${uniqueString(resourceGroup().id)}'

module storage './storage.bicep' = {
  name: 'deploy_${storageName}'
  params: {
    storageName: storageName
  }
}

module kv './keyvault.bicep' = {
  name: 'kv'
  dependsOn: [
    storage
  ]
  params: {
    keyVaultName: 'kv-${substring(uniqueString(subscription().subscriptionId), 0, 6)}-${uniqueString(resourceGroup().id)}'
    storageName: storage.outputs.storageNameOT
  }
}
