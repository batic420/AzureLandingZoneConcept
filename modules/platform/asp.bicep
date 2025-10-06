targetScope = 'resourceGroup'

import { asp } from '../../types/platform/asp.bicep'

param location string
param region string
param environment string
param tags object

param aspConfig asp
param aspInstanceNr int

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: 'asp-${aspConfig.projectName}-${environment}-${region}-${padLeft(aspInstanceNr, 2, '0')}'
  location: location
  kind: aspConfig.osKind

  sku: {
    tier: aspConfig.sku.tier
    name: aspConfig.sku.name
  }

  tags: tags
}

output aspId string = appServicePlan.id
