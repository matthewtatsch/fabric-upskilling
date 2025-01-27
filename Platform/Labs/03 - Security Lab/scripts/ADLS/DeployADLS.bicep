@description('The name of the storage account')

param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'

@description('The name of the resource group for the storage account')
param storageAccountRG string = 'fabric-adls-rg'

@description('The location of the storage account')
//param location string = resourceGroup().location = 'westeurope'
param location string = resourceGroup().location

@description('The name of the storage container')
param containerName string = 'samplecontainer'

@description('The IP address to allow access')
param myIpAddress string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Cool'
    allowBlobPublicAccess: false
    isHnsEnabled: true
    networkAcls: {
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: [
        {
          value: myIpAddress
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
  }
}

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storageAccount.name}/default/${containerName}'
  properties: {
    publicAccess: 'None'
  }
}

output storageAccountName string = storageAccount.name
output containerName string = storageContainer.name
