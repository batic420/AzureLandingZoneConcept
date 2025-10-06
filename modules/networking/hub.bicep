targetScope = 'resourceGroup'

import { hubVnet, hubSnets } from '../../types/networking/vnet.bicep'

param location string
param region string
param environment string
param tags object

param hubConfig hubVnet
param snetConfigs hubSnets

resource hub 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet-${hubConfig.projectName}-${environment}-${region}-${padLeft(hubConfig.instanceNr, 2, '0')}'
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: hubConfig.properties.addressSpace.addressPrefixes
    }
  }

  tags: tags
}

resource snets 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = [for (subnet, i) in snetConfigs: {
  parent: hub
  name: 'snet-${subnet.name}-${environment}-${region}'
  
  properties: {
    addressPrefix: subnet.properties.?addressPrefix
    defaultOutboundAccess: subnet.properties.?defaultOutboundAccess
    privateEndpointNetworkPolicies: subnet.properties.privateEndpointNetworkPolicies
    privateLinkServiceNetworkPolicies: subnet.properties.privateLinkServiceNetworkPolicies
  }
}]

output hubVnetId string = hub.id
