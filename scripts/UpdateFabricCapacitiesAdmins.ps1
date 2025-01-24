#Requires -Module Az.Fabric

# Variables
$resourceGroupName = "FabricUpskillingRG"

# Array of Fabric Capacity names and Admin Members
$fabricCapacities = @(
    # @{ CapacityName = "adminfabcc"; AdminMember = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ CapacityName = "student01fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student01@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student02fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student02@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student03fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student03@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student04fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student04@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student05fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student05@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student06fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student06@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student07fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student07@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student08fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student08@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student09fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student09@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student10fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student10@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student11fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student11@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student12fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student12@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student13fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student13@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student14fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student14@MngEnvMCAP316940.onmicrosoft.com") },
    @{ CapacityName = "student15fabcc"; AdminMember = @("admin@MngEnvMCAP316940.onmicrosoft.com","Student15@MngEnvMCAP316940.onmicrosoft.com") }
)

# Loop through each capacity and create a Microsoft Fabric capacity
foreach ($capacity in $fabricCapacities) {
    Update-AzFabricCapacity `
        -ResourceGroupName $resourceGroupName `
        -CapacityName $capacity.CapacityName `
        -AdministrationMember $capacity.AdminMember
}