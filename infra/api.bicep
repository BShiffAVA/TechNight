param location string
param environmentName string

var resourceToken = toLower(uniqueString(subscription().id, location, environmentName))

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'plan-123'
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
  }
}

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: 'api-${resourceToken}'
  location: location  
  tags: {
    'azd-service-name': 'api'
  }
  properties: {
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|6.0'
      alwaysOn: true
    }
    serverFarmId: appServicePlan.id
  }
}

