$subscriptionId = ""
$region = "northcentralus"

Login-AzureRmAccount -SubscriptionId $subscriptionId

$currentDate = Get-Date -Format yyyyMMdd.HHmmss
$deploymentLabel = "vmimage-$currentDate"

$creds = Get-Credential -Message "Enter admin username and password for VM."

$params = @{
    VMName = "vm-containers-2"; 
    adminUserName = $creds.UserName; 
    adminPassword = $creds.Password; 
    dnsNameForPublicIP = "mcolliervm002"; 
    vmSize = "Standard_DS3_v2"
}

$myTags = @{}
$myTags.Add("alias", "mcollier")
$myTags.Add("deleteAfter", "04/30/2017")

<# -- Create a Windows Server 2016 with Container support --#>
<#
$resourceGroupName = "mcollier-stirtrek"
New-AzureRmResourceGroup -Name $resourceGroupName -Location $region -Tag $myTags

# similar to https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/master/windows-server-container-tools/containers-azure-template/azuredeploy.json, except using Managed Disk.
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName `
                                   -Name $deploymentLabel `
                                   -TemplateUri "https://raw.githubusercontent.com/mcollier/Virtualization-Documentation/live/windows-server-container-tools/containers-azure-template/azuredeploy.json" `
                                   -TemplateParameterObject $params `
                                   -Verbose
#>

<# -- Create a Windows Server 2016 without default Container support --#>   
$resourceGroupName = "mcollier-stirtrek-2"
New-AzureRmResourceGroup -Name $resourceGroupName -Location $region -Tag $myTags

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName `
                                   -Name $deploymentLabel `
                                   -TemplateFile "C:\Projects\ContainersForWindowsDevs\vm-windowsserver2016\azuredeploy.json" `
                                   -TemplateParameterObject $params `
                                   -Verbose                                