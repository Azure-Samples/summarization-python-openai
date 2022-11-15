@description('Specifies the location for resources.')
param location string = 'southcentralus'

param openai_name string
param search_name string
param storage_name string

resource openai_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  kind: 'OpenAI'
  location: location
  name: openai_name
  properties: {
    customSubDomainName: openai_name
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'S0'
  }
}

resource search_name_resource 'Microsoft.Search/searchServices@2021-04-01-preview' = {
  location: location
  name: search_name
  properties: {
    authOptions: {
      apiKeyOnly: {
      }
    }
    disableLocalAuth: false
    disabledDataExfiltrationOptions: []
    encryptionWithCmk: {
      enforcement: 'Unspecified'
    }
    hostingMode: 'default'
    networkRuleSet: {
      bypass: 'None'
      ipRules: []
    }
    partitionCount: 1
    publicNetworkAccess: 'Enabled'
    replicaCount: 1
    semanticSearch: 'disabled'
  }
  sku: {
    name: 'standard'
  }
}

resource storage_name_resource 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  kind: 'StorageV2'
  location: location
  name: storage_name
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    encryption: {
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: false
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
      }
    }
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
    }
}

resource openai_name_davinci_instruct 'Microsoft.CognitiveServices/accounts/deployments@2022-03-01' = {
  parent: openai_name_resource
  name: 'davinci-instruct'
  properties: {
    model: {
      format: 'OpenAI'
      name: 'text-davinci-001'
      version: '1'
    }
    scaleSettings: {
      scaleType: 'Standard'
    }
  }
}

resource openai_name_text_search_curie_doc_001 'Microsoft.CognitiveServices/accounts/deployments@2022-03-01' = {
  parent: openai_name_resource
  name: 'text-search-curie-doc-001'
  properties: {
    model: {
      format: 'OpenAI'
      name: 'text-search-curie-doc-001'
      version: '1'
    }
    scaleSettings: {
      scaleType: 'Standard'
    }
  }
  dependsOn: [
    openai_name_davinci_instruct
  ]
}

resource openai_name_text_search_curie_query_001 'Microsoft.CognitiveServices/accounts/deployments@2022-03-01' = {
  parent: openai_name_resource
  name: 'text-search-curie-query-001'
  properties: {
    model: {
      format: 'OpenAI'
      name: 'text-search-curie-query-001'
      version: '1'
    }
    scaleSettings: {
      scaleType: 'Standard'
    }
  }
  dependsOn: [
    openai_name_text_search_curie_doc_001
  ]
}

resource storage_name_default 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  parent: storage_name_resource
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
    cors: {
      corsRules: [
        {
          allowedHeaders: [
            '*'
          ]
          allowedMethods: [
            'GET'
            'HEAD'
          ]
          allowedOrigins: [
            'https://mlworkspace.azure.ai'
            'https://ml.azure.com'
            'https://*.ml.azure.com'
            'https://mlworkspacecanary.azure.ai'
            'https://mlworkspace.azureml-test.net'
          ]
          exposedHeaders: [
            '*'
          ]
          maxAgeInSeconds: 1800
        }
      ]
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      days: 7
      enabled: true
    }
    isVersioningEnabled: false
    restorePolicy: {
      enabled: false
    }
  }
}

resource storage_name_default_openaiblob 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  parent: storage_name_default
  name: 'openaiblob'
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'None'
  }
}
