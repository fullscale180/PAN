#-----------------------------------------------------
# Import utilities module
#-----------------------------------------------------
Import-module AzureRM.Compute
Import-module AzureRM.Storage
Import-module AzureRM.Network

#-----------------------------------------------------
# Authenticate
#-----------------------------------------------------
#Login-AzureRmAccount

#-----------------------------------------------------
# Select the Subscription by subscriptionId or by Tenant Id
#-----------------------------------------------------
Get-AzureRmSubscription -SubscriptionName "Visual Studio Enterprise" | Select-AzureRMSubscription 

#-----------------------------------------------------
# Create a new deployment
#-----------------------------------------------------
cd 'D:\All Projects\FS180 Clients\PAN'

$deployName = "AzureDeploy"
$location = "westus2"

#-----------------------------------------------------
# Deploy an outbound firewall
#-----------------------------------------------------
$rgName = "PAN" 
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile .\azureDeployInfra.json -TemplateParameterFile .\azureDeployInfra.parameters.json 

#-----------------------------------------------------
# Deploy inbound firewall and backend for app1
#-----------------------------------------------------
$rgName = "APP1" 
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile .\azureDeployApp.json -TemplateParameterFile .\azureDeployApp1.parameters.json 

#-----------------------------------------------------
# Deploy inbound firewall and backend for app2
#-----------------------------------------------------
$rgName = "APP2" 
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile .\azureDeployApp.json -TemplateParameterFile .\azureDeployApp2.parameters.json 

