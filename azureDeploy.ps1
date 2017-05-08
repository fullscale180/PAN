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
$rgName = "PAN" 
$templateFile = "$projectPath\azureDeployInfra.json"
$parameterFile = "$projectPath\azureDeployInfra.parameters.json"
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile $templateFile -TemplateParameterFile $parameterFile

#-----------------------------------------------------
# Deploy inbound firewall and backend for app1 use parameter object
#-----------------------------------------------------
$rgName = "APP1" 
$templateFile = "$projectPath\azureDeployApp.json"
$parameterFile = "$projectPath\azureDeployApp.parameters.json"
$rg = New-AzureRMResourceGroup -name $rgName -location $location
New-AzureRMResourceGroupDeployment -ResourceGroupName $rgName -Name $deployName -TemplateFile $templateFile -TemplateParameterObject $parameterFile


