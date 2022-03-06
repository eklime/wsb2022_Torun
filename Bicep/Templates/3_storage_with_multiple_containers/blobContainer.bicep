param storageName string
param containerName string

@allowed([
  'Blob'
  'Container'
  'None'
])
param publicAccess string = 'None'

resource existingStorage 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: storageName
}

resource container_resource 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: '${existingStorage.name}/default/${containerName}'
  properties: {
    publicAccess: publicAccess
  }
}
