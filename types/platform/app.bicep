// APP
@export()
type app = {
  projectName: string
  instanceNr: int

  properties: {
    publicAccess: 'Enabled' | 'Disabled'

    siteConfig: {
      alwaysOn: bool
      nodeVersion: string
      numberOfWorkers: int
    }
  }
}
