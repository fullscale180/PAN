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
cd 'D:\All Projects\FS180 Clients\PAN\azure-segmented'

$deployName = "AzureDeploy"
$location = "westus2"

#-----------------------------------------------------
# Deploy outbound firewall
#-----------------------------------------------------
$rgName = "PAN1" 
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile .\azureDeployInfra.json -TemplateParameterFile .\azureDeployInfra.parameters.json 

#-----------------------------------------------------
# Deploy application firewall and backend
#-----------------------------------------------------
$rgName = "PAN1" 
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile .\azureDeployApp.json -TemplateParameterFile .\azureDeployApp.parameters.json 


