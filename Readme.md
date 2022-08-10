# Deploy the Lab Environment
## Pre-requisites
* Access to an Azure subscription or resource group where you can deploy resources. 
* Visual Studio Code 
* Azure CLI installed
* Git installed on your machine

## Deployment Steps
1. Clone the repository 
1. Open VSCode and start a new terminal ``Terminal > New Terminal``
1. Sign in to Azure in the Azure CLI. A window should pop up to complete your login ``az login``
1. Check which subscription is set to default. ``az account show``
1. If you need to update the target subscription use the ``az account set --subscription {your-subscription-guid-here}``
1. Create a resource group in the portal or by using the az cli, i.e. ``az group create --location eastus2 --name RG-SecureAILab-01`` (update parameters to the location and name that you prefer). 
1. In the CLI, navigate to the deploy folder ``cd ./deploy``
1. Deploy the bicep template ``az deployment group create --resource-group {your_resource_group_name} --template-file ./template.bicep --parameters prefix={your_3_letter_prefix} adminPassword={you_password_for_VM_admin}``
    * your_resource_group_name: the resource group where lab resources will be deployed. 
    * prefix: a 3-letter prefix used to make sure your resources are unique. This will also be the admin login name for the deployed virtual machine.
    * adminPassword: a password for the VM admin user.
    * An example of this command would look like:  ``az deployment group create --resource-group RG-SecureAILab-01 --template-file ./template.bicep --parameters prefix=bdl adminPassword=SomeSuperSecurePass!88``
1. View deployment progress by navigating to the resource group in the Azure Portal and then clicking on the "Deployments" tab. A deployment named "template" should be visible. Clicking on it will show the individual resource deployments. 
