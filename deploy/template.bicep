param prefix string
@secure()
param adminPass string
param location string = resourceGroup().location

param vmAdminUserName string = prefix
param bastionHosts_bdl_bastion_01_name string = '${prefix}-bastion-${uniqueString(resourceGroup().id)}'
param virtualMachines_bdl_jumpbox_01_name string = substring('${prefix}jmpbx-${uniqueString(resourceGroup().id)}', 0, 15)
param virtualNetworks_bdl_ssai_vnet_01_name string = '${prefix}-vnet-${uniqueString(resourceGroup().id)}'
param searchServices_cogsvc_06_cogsearch_name string = '${prefix}-cogsvc-06-cogsearch-${uniqueString(resourceGroup().id)}'
param accounts_cogsvc_03_speech_name string = '${prefix}-cogsvc-03-speech-${uniqueString(resourceGroup().id)}'
param networkInterfaces_bdl_jumpbox_01134_name string = '${prefix}-jumpbox-nic-${uniqueString(resourceGroup().id)}' 
param publicIPAddresses_bdl_jumpbox_01_ip_name string = '${prefix}-jumpbox-ip-${uniqueString(resourceGroup().id)}'
param storageAccounts_bdlsupersecureaistg_name string = substring('${prefix}secureaistg${uniqueString(resourceGroup().id)}', 0, 24)
param accounts_cogsvc_01_unified_name string = '${prefix}-cogsvc-01-unified-${uniqueString(resourceGroup().id)}'
param accounts_cogsvc_04_language_name string = '${prefix}-cogsvc-04-language-${uniqueString(resourceGroup().id)}' 
param accounts_cogsvc05customvision_name string = substring('${prefix}customvision${uniqueString(resourceGroup().id)}', 0, 24)
param networkSecurityGroups_bdl_default_nsg_01_name string = '${prefix}-nsg-${uniqueString(resourceGroup().id)}'
param publicIPAddresses_bdl_ssai_vnet_bastion_ip_name string = '${prefix}-bastion-ip-${uniqueString(resourceGroup().id)}'
param accounts_cogsvc_02_formrecognizer_name string = '${prefix}-cogsvc-02-formrecognizer-${uniqueString(resourceGroup().id)}'
param accounts_cogsvc_06_computervision_name string = '${prefix}-cogsvc-06-computervision-${uniqueString(resourceGroup().id)}'
param schedules_shutdown_computevm_bdl_jumpbox_01_name string = 'shutdown-computevm-${bastionHosts_bdl_bastion_01_name}'
param accounts_cogsvc05customvision_Prediction_name string = '${networkSecurityGroups_bdl_default_nsg_01_name}-Prediction'

resource accounts_cogsvc_01_unified_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc_01_unified_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'CognitiveServices'
  identity: {
    type: 'None'
  }
  properties: {
    apiProperties: {
    }
    customSubDomainName: accounts_cogsvc_01_unified_name
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_cogsvc_02_formrecognizer_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc_02_formrecognizer_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'FormRecognizer'
  identity: {
    type: 'None'
  }
  properties: {
    customSubDomainName: accounts_cogsvc_02_formrecognizer_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_cogsvc_03_speech_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc_03_speech_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'SpeechServices'
  identity: {
    type: 'None'
  }
  properties: {
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_cogsvc_04_language_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc_04_language_name
  location: location
  sku: {
    name: 'S'
  }
  kind: 'TextAnalytics'
  identity: {
    type: 'None'
  }
  properties: {
    apiProperties: {
    }
    customSubDomainName: accounts_cogsvc_04_language_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_cogsvc05customvision_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc05customvision_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'CustomVision.Training'
  properties: {
    customSubDomainName: accounts_cogsvc05customvision_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_cogsvc05customvision_Prediction_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc05customvision_Prediction_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'CustomVision.Prediction'
  properties: {
    customSubDomainName: accounts_cogsvc05customvision_Prediction_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_cogsvc_06_computervision_name_resource 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: accounts_cogsvc_06_computervision_name
  location: location
  sku: {
    name: 'S1'
  }
  kind: 'ComputerVision'
  identity: {
    type: 'None'
  }
  properties: {
    customSubDomainName: accounts_cogsvc_06_computervision_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource networkSecurityGroups_bdl_default_nsg_01_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_bdl_default_nsg_01_name
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1010
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'SSH'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1020
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_bdl_jumpbox_01_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_bdl_jumpbox_01_ip_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '104.211.26.138'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_bdl_ssai_vnet_bastion_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_bdl_ssai_vnet_bastion_ip_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '40.114.114.185'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_bdl_ssai_vnet_01_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_bdl_ssai_vnet_01_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: networkSecurityGroups_bdl_default_nsg_01_name_resource.id
          }
        }
      }
      {
        name: 'vpn'
        properties: {
          addressPrefix: '10.1.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: networkSecurityGroups_bdl_default_nsg_01_name_resource.id
          }
        }
      }
      {
        name: 'privateendpoints'
        properties: {
          addressPrefix: '10.1.2.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: networkSecurityGroups_bdl_default_nsg_01_name_resource.id
          }
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.3.0/24'
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource searchServices_cogsvc_06_cogsearch_name_resource 'Microsoft.Search/searchServices@2021-04-01-preview' = {
  name: searchServices_cogsvc_06_cogsearch_name
  location: location
  sku: {
    name: 'basic'
  }
  properties: {
    replicaCount: 1
    partitionCount: 1
    hostingMode: 'default'
    publicNetworkAccess: 'Enabled'
    networkRuleSet: {
      ipRules: []
      bypass: 'None'
    }
    encryptionWithCmk: {
      enforcement: 'Unspecified'
    }
    disableLocalAuth: false
    authOptions: {
      apiKeyOnly: {
      }
    }
    disabledDataExfiltrationOptions: []
    semanticSearch: 'disabled'
  }
}

resource storageAccounts_bdlsupersecureaistg_name_resource 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccounts_bdlsupersecureaistg_name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource virtualMachines_bdl_jumpbox_01_name_resource 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: virtualMachines_bdl_jumpbox_01_name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      // imageReference: {
      //   publisher: 'microsoft-dsvm'
      //   offer: 'dsvm-win-2019'
      //   sku: 'winserver-2019'
      //   version: 'latest'
      // }
      imageReference: {
        publisher: 'microsoftwindowsdesktop'
        offer: 'windows-11'
        sku: 'win11-21h2-pro'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_bdl_jumpbox_01_name}_OsDisk_1_ddedbf3fb1c44764b80ea9f550358482'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
            storageAccountType: 'Standard_LRS'
        }
        
        deleteOption: 'Delete'
        diskSizeGB: 128
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_bdl_jumpbox_01_name
      adminUsername: vmAdminUserName
      adminPassword: adminPass
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_bdl_jumpbox_01134_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    licenseType: 'Windows_Server'
  }
}

resource schedules_shutdown_computevm_bdl_jumpbox_01_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_bdl_jumpbox_01_name
  location: location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '1900'
    }
    timeZoneId: 'Eastern Standard Time'
    notificationSettings: {
      status: 'Disabled'
    }
    targetResourceId: virtualMachines_bdl_jumpbox_01_name_resource.id
  }

}

resource networkSecurityGroups_bdl_default_nsg_01_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_bdl_default_nsg_01_name_resource
  name: 'RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_bdl_default_nsg_01_name_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_bdl_default_nsg_01_name_resource
  name: 'SSH'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1020
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource virtualNetworks_bdl_ssai_vnet_01_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_bdl_ssai_vnet_01_name_resource
  name: 'AzureBastionSubnet'
  properties: {
    addressPrefix: '10.1.3.0/24'
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_bdl_ssai_vnet_01_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_bdl_ssai_vnet_01_name_resource
  name: 'default'
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_bdl_ssai_vnet_01_name_privateendpoints 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_bdl_ssai_vnet_01_name_resource
  name: 'privateendpoints'
  properties: {
    addressPrefix: '10.1.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_bdl_ssai_vnet_01_name_vpn 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_bdl_ssai_vnet_01_name_resource
  name: 'vpn'
  properties: {
    addressPrefix: '10.1.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource storageAccounts_bdlsupersecureaistg_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageAccounts_bdlsupersecureaistg_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_bdlsupersecureaistg_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-09-01' = {
  parent: storageAccounts_bdlsupersecureaistg_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_bdlsupersecureaistg_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-09-01' = {
  parent: storageAccounts_bdlsupersecureaistg_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_bdlsupersecureaistg_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-09-01' = {
  parent: storageAccounts_bdlsupersecureaistg_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource bastionHosts_bdl_bastion_01_name_resource 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: bastionHosts_bdl_bastion_01_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    dnsName: 'bst-d22f29f2-32d9-4704-ada1-8bf621b62a61.bastion.azure.com'
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_bdl_ssai_vnet_bastion_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_bdl_ssai_vnet_01_name_AzureBastionSubnet.id
          }
        }
      }
    ]
  }
}

resource networkInterfaces_bdl_jumpbox_01134_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_bdl_jumpbox_01134_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.1.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_bdl_jumpbox_01_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_bdl_ssai_vnet_01_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    networkSecurityGroup: {
      id: networkSecurityGroups_bdl_default_nsg_01_name_resource.id
    }
  }
}
