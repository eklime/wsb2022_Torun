param storageName string
param containerName string

@allowed([
  'Blob'
  'Container'
  'None'
])
param publicAccess string = 'None'

resource container_resource 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: '${storageName}/default/${containerName}'
  properties: {
    publicAccess: publicAccess
    metadata: {
    'School':'WSB'  
    }
  }
}
