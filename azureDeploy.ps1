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
$location = "westus2"
$deployName = "AzureDeploy"
$projectpath = "D:\All Projects\FS180 Clients\PAN"

#-----------------------------------------------------
# Deploy an outbound firewall using parameter file
#-----------------------------------------------------
$infaRGName = "DATEST" 
$templateFile = "$projectPath\azureDeployInfra.json"
$parameterObject = @{"storageName" = "dapanstorage"; "mgmtPublicIPDns" = "dapanmgmt"}

$rg = New-AzureRMResourceGroup -name $infaRGName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $infaRGName -Name $deployName -TemplateFile $templateFile -TemplateParameterObject $parameterObject 

#-----------------------------------------------------
# Deploy inbound firewall and backend for app1 use parameter file
#-----------------------------------------------------
$appRGName = "DAAPP1"
$templateFile = "$projectPath\azureDeployApp.json"
$parameterObject = @{ "appPrefix" = "a1"; "virtualNetworkRG"   = $infaRGName}

$rg = New-AzureRMResourceGroup -name $appRGName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $appRGName -Name $deployName -TemplateFile $templateFile -TemplateParameterObject $parameterObject 


