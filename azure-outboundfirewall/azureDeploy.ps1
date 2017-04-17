#-----------------------------------------------------
# Import utilities module
#-----------------------------------------------------
Import-module AzureRM.Compute
Import-module AzureRM.Storage
Import-module AzureRM.Network
#Import-module AzureRM.ApiManagement
#Import-module AzureRM.Automation
#Import-module AzureRM.Backup
#Import-module AzureRM.KeyVault
#Import-module AzureRM.WebSites
#Import-module AzureRM.Resources

#-----------------------------------------------------
# Authenticate
#-----------------------------------------------------
Login-AzureRmAccount

#-----------------------------------------------------
# Select the Subscription by subscriptionId or by Tenant Id
#-----------------------------------------------------
Get-AzureRmSubscription -SubscriptionName "Visual Studio Enterprise" | Select-AzureRMSubscription 

#-----------------------------------------------------
# Create a new deployment
#-----------------------------------------------------
cd 'D:\All Projects\FS180 Clients\PAN\azure-applicationgateway-2way'

$deployName = "AzureDeploy"
$location = "westus2"

#-----------------------------------------------------
# Create a new resource group
#-----------------------------------------------------
$rgName = "PAN1" 
$rg = New-AzureRMResourceGroup -name $rgName -location $location

#-----------------------------------------------------
# Deploy PAN Application Gatway
#-----------------------------------------------------
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile .\azuredeploy.json -TemplateParameterFile .\azureDeploy.parameters.json 


