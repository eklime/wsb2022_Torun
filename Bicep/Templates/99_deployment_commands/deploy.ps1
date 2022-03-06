
$resourceGroup = "bicep"

#region Scenario 1
#az deployment group create -g $resourceGroup -f ./1_raw_storage/storage.bicep -n 1_storage --no-wait
az deployment group create -g $resourceGroup -f ./1_raw_storage/deploy.bicep -n 1_storage --no-wait
#endregion

#region Scenario 2
az deployment group create -g $resourceGroup -f ./2_storage_with_share_and_container/storage.bicep -n 2_storage --parameters containerName=wsbcontainer shareName=wsbShare storageName=wsbstg2sharecontainer --no-wait
#endregion

#region Scenario 2
az deployment group create -g $resourceGroup -f ./3_storage_with_multiple_containers/storage.bicep -n 3_storage --parameters storageName=wsbstg3multicontainers --no-wait
#endregion