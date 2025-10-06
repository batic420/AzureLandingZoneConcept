targetScope = 'resourceGroup'

import { spokeVnet } from '../../types/networking/vnet.bicep'

param location string
param region string
param environment string
param tags object

param spokeConfig spokeVnet
param spokeVnetInstanceNr int

resource spoke 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet-${spokeConfig.projectName}-${environment}-${region}-${padLeft(spokeVnetInstanceNr, 2, '0')}'
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: spokeConfig.properties.addressSpace.addressPrefixes
    }
    subnets: [
      for subnet in spokeConfig.properties.subnets: {
        name: 'snet-${subnet.projectName}-${environment}-${region}'
        
        properties: {
          addressPrefix: subnet.properties.?addressPrefix
          delegations: subnet.properties.?delegation
          privateEndpointNetworkPolicies: subnet.properties.privateEndpointNetworkPolicies
          privateLinkServiceNetworkPolicies: subnet.properties.privateLinkServiceNetworkPolicies
        }
      }
    ]
  }

  tags: tags
}

output snetId string = spoke.properties.subnets[1].id
output snetName string = spoke.properties.subnets[1].name
