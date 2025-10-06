targetScope = 'resourceGroup'

import { app } from '../../types/platform/app.bicep'

param location string
param region string
param environment string
param tags object

param appConfig app
param aspId string
param snetId string

resource appService 'Microsoft.Web/sites@2024-11-01' = {
  name: 'app-${appConfig.projectName}-${environment}-${region}-${padLeft(appConfig.instanceNr, 2, '0')}'
  location: location

  properties: {
    publicNetworkAccess: appConfig.properties.publicAccess
    serverFarmId: aspId
    virtualNetworkSubnetId: snetId

    siteConfig: {
      alwaysOn: appConfig.properties.siteConfig.alwaysOn
      nodeVersion: appConfig.properties.siteConfig.nodeVersion
      numberOfWorkers: appConfig.properties.siteConfig.numberOfWorkers
    }
  }

  tags: tags
}
