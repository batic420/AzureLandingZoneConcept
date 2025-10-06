///// Level of resource deployment -> subscription bc of resource groups /////
targetScope = 'subscription'

///// All user defined types /////
import { hubVnet, hubSnets, spokeVnet } from 'types/networking/vnet.bicep'
import { asp } from 'types/platform/asp.bicep'
import { app } from 'types/platform/app.bicep'
import { stapp } from 'types/platform/stapp.bicep'

///// Global parameters /////
param location string
param region string
@allowed([
  'dev'
  'stage'
  'prod'
  'local'
])
param environment string
param tags object

///// resource group/s /////
param coreProjectName string
param spokeProjectName string

///// network parameters /////
// hub
param hubConfig hubVnet
param snetConfigs hubSnets

// spoke/s
param spokeConfig spokeVnet
param spokeVnetInstanceNr int

// private dns
param zoneName string
param networkLinkName string

///// platform parameters /////
// asp
param aspConfig asp
param aspInstanceNr int

// app
param appConfig app

// stapp 
param stappConfig stapp

///// resource group for platform landing zone resources /////
resource coreRg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'rg-${coreProjectName}-${environment}-${region}'
  location: location

  tags: tags
}

///// resource group for application landing zone resources (can be expanded) /////
resource spokeRg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'rg-${spokeProjectName}-${environment}-${region}'
  location: location

  tags: tags
}

///// Hub network -> platform resource /////
module hubNetwork 'modules/networking/hub.bicep' = {
  scope: coreRg
  name: 'hubNetwork'
  params: {
    environment: environment
    location: location
    region: region

    hubConfig: {
      projectName: hubConfig.projectName
      instanceNr: hubConfig.instanceNr

      properties: {
        addressSpace: {
          addressPrefixes: hubConfig.properties.addressSpace.addressPrefixes
        }
        dhcp: {}
      }
    }

    snetConfigs: snetConfigs

    tags: tags
  }
}

///// Spoke network/s -> part of application resources /////
module spokeNetwork 'modules/networking/spoke.bicep' = {
  scope: spokeRg
  name: 'spokeNetwork'
  params: {
    environment: environment
    location: location
    region: region

    spokeVnetInstanceNr: spokeVnetInstanceNr
    spokeConfig: {
      projectName: spokeConfig.projectName
      properties: {
        addressSpace: {
          addressPrefixes: spokeConfig.properties.addressSpace.addressPrefixes
        }
        dhcp: {}
        subnets: spokeConfig.properties.subnets
      }
    }

    tags: tags
  }
}

///// Private DNS zone/s -> part of platform resources /////
module privateDns 'modules/networking/pdsz.bicep' = {
  scope: coreRg
  name: 'privateDns'
  params: {
    networkLinkName: networkLinkName
    zoneName: zoneName
    networkLinkVnetId: hubNetwork.outputs.hubVnetId

    tags: tags
  }
}

///// App Service Plan -> part of application resources /////
module appServicePlan 'modules/platform/asp.bicep' = {
  scope: spokeRg
  name: 'appServicePlan'
  params: {
    environment: environment
    location: location
    region: region

    aspInstanceNr: aspInstanceNr
    aspConfig: {
      projectName: aspConfig.projectName
      osKind: aspConfig.osKind
      sku: {
        tier: aspConfig.sku.tier
        name: aspConfig.sku.name
      }
    }

    tags: tags
  }
}

///// App Service/s -> part of application resources /////
module appService 'modules/platform/app.bicep' = {
  scope: spokeRg
  name: 'appService'
  params: {
    environment: environment
    location: location
    region: region

    appConfig: {
      projectName: appConfig.projectName
      instanceNr: appConfig.instanceNr

      properties: appConfig.properties
    }

    aspId: appServicePlan.outputs.aspId
    snetId: spokeNetwork.outputs.snetId

    tags: tags
  }
}

///// Static Web App/s -> part of application resources /////
module staticWebApp 'modules/platform/stapp.bicep' = {
  scope: spokeRg
  name: 'staticWebApp'
  params: {
    environment: environment
    location: location
    region: region

    stappConfig: {
      projectName: stappConfig.projectName
      instanceNr: stappConfig.instanceNr

      sku: {
        tier: stappConfig.sku.tier
        name: stappConfig.sku.name
      }

      properties: {
        buildProperties: {
          skipGithubActionWorkflowGeneration: stappConfig.properties.buildProperties.skipGithubActionWorkflowGeneration
        }
      }
    }

    tags: tags
  }
}

///// Outputs to check correct resource ids /////
output appServicePlanId string = appServicePlan.outputs.aspId
output spokeSnetServerFarmId string = spokeNetwork.outputs.snetId
output spokeSnetServerFarmName string = spokeNetwork.outputs.snetName
