#Requires -Module Az.Fabric

# Variables
$resourceGroupName = "FabricUpskillingRG"
$location = "Canada Central"
$sku = "F4"

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Array of Fabric Capacity names and Admin Members
$fabricCapacities = @(
    @{ CapacityName = "adminfabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student01fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student02fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student03fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student04fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student05fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student06fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student07fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student08fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student09fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student10fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student11fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student12fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student13fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student14fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student15fabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" }
)

# Loop through each capacity and create a Microsoft Fabric capacity
foreach ($capacity in $fabricCapacities) {
    New-AzFabricCapacity `
        -ResourceGroupName $resourceGroupName `
        -CapacityName $capacity.CapacityName `
        -Location $location `
        -SkuName $sku `
        -AdministrationMember $capacity.AdminMember
}