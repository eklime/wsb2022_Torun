param storageName string
param shareName string
param shareQuota int = 50

resource file_share 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-06-01' = {
  name: '${storageName}/default/${shareName}'
  properties: {
    shareQuota: shareQuota
    enabledProtocols: 'SMB'
    accessTier: 'TransactionOptimized'
  }
}
