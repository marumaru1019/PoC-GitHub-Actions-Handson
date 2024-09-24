param location string = resourceGroup().location
param webAppName string = 'app-actions-sample'
param appServicePlanName string = 'ActionsAppServicePlan'

@description('Enable public network access')
param enablePublicNetworkAccess bool = true

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'P1v2'
    tier: 'PremiumV2'
    size: 'P1v2'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    publicNetworkAccess: enablePublicNetworkAccess ? 'Enabled' : 'Disabled'
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.9'
      appSettings: [
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
      ]
      appCommandLine: 'uvicorn main:app'
    }
    httpsOnly: true
  }
}
