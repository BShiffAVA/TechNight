targetScope = 'subscription'

param location string
param environmentName string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
}

module api './api.bicep' = {
  scope: rg
  name: 'api-module'
  params: {
    location: location
    environmentName: environmentName
  }
}


