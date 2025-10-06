targetScope = 'resourceGroup'

param tags object

param zoneName string
param networkLinkName string
param networkLinkVnetId string

resource pdsz 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: zoneName
  location: 'global'
  properties: {}

  tags: tags
}

resource pdszNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: pdsz
  name: networkLinkName
  location: 'global'

  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: networkLinkVnetId
    }
  }

  tags: tags
}
