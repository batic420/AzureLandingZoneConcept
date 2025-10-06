using '../main.bicep'

// global parameters
param location = 'westeurope' // example location
param region = 'weu' // short form for the resource names
param environment = 'stage'
param tags = {
  Environment: 'Stage'
  ResponsiblePersonApp: 'placeholder@example.com' // update with real value
  ResponsiblePersonOps: 'placeholder@example.com' // update with real value
  Priority: 'Medium'
  CostCenter: 'placeholder' // update with real value
}

// resource group parameters
param coreProjectName = 'platform-core'
param spokeProjectName = 'web-apps'

// network parameters
param spokeVnetInstanceNr = 1

param hubConfig = {
  projectName: 'platform-core'
  instanceNr: 1

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/22'
      ]
    }
    dhcp: {} // using the default Azure DNS
  }
}

param snetConfigs = [
  {
    name: 'outbound'

    properties: {
      addressPrefix: '10.1.0.0/26'
      natGateway: {}
      nsg: {}
      privateEndpointNetworkPolicies: 'Enabled'
      privateLinkServiceNetworkPolicies: 'Enabled'
      rt: {}
    }
  }
  {
    name: 'internal'
    
    properties: {
      addressPrefix: '10.1.0.64/26'
      natGateway: {}
      nsg: {}
      privateEndpointNetworkPolicies: 'Enabled'
      privateLinkServiceNetworkPolicies: 'Enabled'
      rt: {}
    }
  }
]

param spokeConfig = {
  projectName: 'basic-web-apps'

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.4.0/22'
      ]
    }
    dhcp: {}
    subnets: [
      {
        projectName: 'private-endpoints'

        properties: {
          addressPrefix: '10.1.4.0/26'
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          natGateway: {}
          rt: {}
          nsg: {}
        }
      }
      {
        projectName: 'apps-outbound'

        properties: {
          addressPrefix: '10.1.4.64/26'
          delegation: [
            {
              name: 'DelegationForServerFarm'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          natGateway: {}
          rt: {}
          nsg: {}
        }
      }
      {
        projectName: 'management'

        properties: {
          addressPrefix: '10.1.4.128/26'
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          natGateway: {}
          rt: {}
          nsg: {}
        }
      }
    ]
  }
}

// private dns
param zoneName = 'privatelink.azurestaticapps.net'
param networkLinkName = 'to-vnet-platform-core'

// platform parameters
param aspInstanceNr = 1

param aspConfig = {
  projectName: 'basic-web-apps'
  osKind: 'linux'

  sku: {
    tier: 'Basic'
    name: 'B1'
  }
}

param appConfig = {
  projectName: 'basic-web-site'
  instanceNr: 1

  properties: {
    publicAccess: 'Disabled'

    siteConfig: {
      alwaysOn: true
      nodeVersion: 'NODE|22-lts'
      numberOfWorkers: 1
    }
  }
}

param stappConfig = {
  projectName: 'default-web-site'
  instanceNr: 1

  sku: {
    name: 'Standard'
    tier: 'Standard'
  }

  properties: {
    buildProperties: {
      skipGithubActionWorkflowGeneration: true
    }
  }
}
