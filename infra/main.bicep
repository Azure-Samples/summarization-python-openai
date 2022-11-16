targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

param openAiAccountName string = ''
param resourceGroupName string = ''
param storageAccountName string = ''
param searchServicesName string = ''

var abbrs = loadJsonContent('./abbreviations.json')
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))
var tags = { 'azd-env-name': environmentName }

// Organize resources in a resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags
}

module openAiAccount 'core/ai/openai-account.bicep' = {
  scope: rg
  name: 'openai'
  params: {
    name: !empty(openAiAccountName) ? openAiAccountName : '${abbrs.cognitiveServicesAccounts}${resourceToken}'
    location: location
    tags: tags
    deployments: [
      {
        name: 'davinci-instruct'
        model: {
          format: 'OpenAI'
          name: 'text-davinci-001'
          version: '1'
        }
        scaleSettings: {
          scaleType: 'Standard'
        }
      }
      {
        name: 'text-search-curie-doc-001'
        model: {
          format: 'OpenAI'
          name: 'text-search-curie-doc-001'
          version: '1'
        }
        scaleSettings: {
          scaleType: 'Standard'
        }
      }
      {
        name: 'text-search-curie-query-001'
        model: {
          format: 'OpenAI'
          name: 'text-search-curie-query-001'
          version: '1'
        }
        scaleSettings: {
          scaleType: 'Standard'
        }
      }
    ]
  }
}

module searchServices 'core/search/search-services.bicep' = {
  scope: rg
  name: 'search-services'
  params: {
    name: !empty(searchServicesName) ? searchServicesName : '${abbrs.searchSearchServices}${resourceToken}'
    location: location
    tags: tags
  }
}

// Backing storage for Azure functions backend API
module storage 'core/storage/storage-account.bicep' = {
  name: 'storage'
  scope: rg
  params: {
    name: !empty(storageAccountName) ? storageAccountName : '${abbrs.storageStorageAccounts}${resourceToken}'
    location: location
    tags: tags
    publicNetworkAccess: 'Enabled'
    containers: [
      {
        name: 'openaiblob'
      }
    ]
  }
}

// App outputs
output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_STORAGE_ACCOUNT_NAME string = storage.outputs.name
output OPENAI_API_KEY string = openAiAccount.outputs.key
output OPENAI_ENDPOINT string = openAiAccount.outputs.endpoint
output SEARCH_API_KEY string = searchServices.outputs.key
output SEARCH_ENDPOINT string = searchServices.outputs.endpoint
