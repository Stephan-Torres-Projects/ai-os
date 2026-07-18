// AI OS v2 — Azure footprint. Phase 0: definition only, no deployment.
// Deploy (Phase 1): az deployment group create -g <rg> -f infra/main.bicep
// Naming: aios-<component>-<env>. One resource group holds the whole system
// so cost, tagging, and teardown are a single surface.

@description('Deployment location. West Europe keeps everything in the EU Data Boundary story.')
param location string = 'westeurope'

@description('Environment suffix')
@allowed(['dev', 'prod'])
param env string = 'dev'

var prefix = 'aios'
var tags = {
  system: 'ai-os-v2'
  env: env
  managedBy: 'bicep'
}

// ---- Lab 00: content pipeline ------------------------------------------
// Consumption-plan Function App: near-zero idle cost, pay-per-execution.

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${prefix}st${env}${uniqueString(resourceGroup().id)}'
  location: location
  tags: tags
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
}

resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: '${prefix}-plan-${env}'
  location: location
  tags: tags
  sku: { name: 'Y1', tier: 'Dynamic' } // Consumption
  properties: {}
}

resource funcApp 'Microsoft.Web/sites@2023-12-01' = {
  name: '${prefix}-contentpipe-${env}'
  location: location
  tags: tags
  kind: 'functionapp,linux'
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'Python|3.11'
      appSettings: [
        { name: 'AzureWebJobsStorage', value: 'DefaultEndpointsProtocol=https;AccountName=${storage.name};AccountKey=${storage.listKeys().keys[0].value}' }
        { name: 'FUNCTIONS_EXTENSION_VERSION', value: '~4' }
        { name: 'FUNCTIONS_WORKER_RUNTIME', value: 'python' }
        // Secrets (GitHub PAT, Anthropic API key) move to Key Vault references
        // in Phase 1 — never plain app settings, never in this file.
      ]
    }
  }
}

// ---- Phase 2 placeholders (declared later, listed here as intent) ------
// - GPU spot VM (NC-series T4) for self-deployed NIM  -> nim-vm.bicep
// - Key Vault for pipeline secrets                    -> keyvault.bicep
// - Foundry project resources                          -> foundry.bicep

output functionAppName string = funcApp.name
output functionPrincipalId string = funcApp.identity.principalId
