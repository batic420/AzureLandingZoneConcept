targetScope = 'resourceGroup'

import { stapp } from '../../types/platform/stapp.bicep'

param location string
param region string
param environment string
param tags object

param stappConfig stapp

resource staticWebApp 'Microsoft.Web/staticSites@2024-11-01' = {
  name: 'stapp-${stappConfig.projectName}-${environment}-${region}-${padLeft(stappConfig.instanceNr, 2, '0')}'
  location: location

  sku: {
    tier: stappConfig.sku.tier
    name: stappConfig.sku.name
  }

  properties: {
    buildProperties: {
      skipGithubActionWorkflowGeneration: stappConfig.properties.buildProperties.skipGithubActionWorkflowGeneration
    }
  }

  tags: tags
}
