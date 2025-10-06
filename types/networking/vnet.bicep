// HUB
@export()
type hubVnet = {
  projectName: string
  instanceNr: int

  properties: {
    addressSpace: {
      addressPrefixes: [
        string
      ]
    }
    dhcp: {
      dnsServers: [
        string
      ]?
    }
  }
}

type hubSnet = {
  name: string
  properties: {
    addressPrefix: string?
    addressPrefixes: [
      string
    ]?
    defaultOutboundAccess: bool?
    natGateway: {
      id: string?
    }
    nsg: {
      id: string?
    }
    privateEndpointNetworkPolicies: 'Enabled' | 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled' | 'Disabled'
    rt: {
      id: string?
    }
  }
}

// SPOKE
@export()
type spokeVnet = {
  projectName: string

  properties: {
    addressSpace: {
      addressPrefixes: [
        string
      ]
    }
    dhcp: {
      dnsServers: [
        string
      ]?
    }
    subnets: spokeSubnet[]
  }
}

type spokeSubnet = {
  projectName: string
  properties: {
    addressPrefix: string?
    addressPrefixes: [
      string
    ]?
    delegation: [
      {
        name: string
        properties: {
          serviceName: string
        }
      }
    ]?
    defaultOutboundAccess: bool?
    natGateway: {
      id: string?
    }
    nsg: {
      id: string?
    }
    privateEndpointNetworkPolicies: 'Enabled' | 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled' | 'Disabled'
    rt: {
      id: string?
    }
  }
}

// Create an array for all the subnets in the hub vnet
@export()
type hubSnets = hubSnet[]

// Either create a single spoke vnet or declare an array
@export()
type spokeVnets = spokeVnet[]
