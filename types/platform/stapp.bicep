// STAPP
@export()
type stapp = {
  projectName: string
  instanceNr: int

  sku: {
    name: string
    tier: string
  }

  properties: {
    publicNetworkAccess: 'Enabled' | 'Disabled'?
    repositoryToken: string?
    repositoryUrl: string?

    buildProperties: {
      skipGithubActionWorkflowGeneration: bool
    }

    templateProperties: {
      templateRepositoryUrl: string?
      isPrivate: bool?
      owner: string?
    }?
  }
}
