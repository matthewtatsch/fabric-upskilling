#Requires -Module Az

$location = "Canada Central"

# List of user IDs and associated resource group names
$resourceGroups = @(
    @{ ResourceGroupName = "fabric-admin-rg"; ContributorID = "admin@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student01-rg"; ContributorID = "Student01@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student02-rg"; ContributorID = "Student02@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student03-rg"; ContributorID = "Student03@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student04-rg"; ContributorID = "Student04@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student05-rg"; ContributorID = "Student05@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student06-rg"; ContributorID = "Student06@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student07-rg"; ContributorID = "Student07@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student08-rg"; ContributorID = "Student08@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student09-rg"; ContributorID = "Student09@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student10-rg"; ContributorID = "Student10@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student11-rg"; ContributorID = "Student11@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student12-rg"; ContributorID = "Student12@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student13-rg"; ContributorID = "Student13@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student14-rg"; ContributorID = "Student14@MngEnvMCAP316940.onmicrosoft.com" },
    @{ ResourceGroupName = "fabric-student15-rg"; ContributorID = "Student15@MngEnvMCAP316940.onmicrosoft.com" }
)

# Loop through each assignment
foreach ($resourceGroup in $resourceGroups) {
    $contributorId = $resourceGroup.ContributorId
    $resourceGroupName = $resourceGroup.ResourceGroupName

    # Create the resource group
    New-AzResourceGroup -Name $resourceGroupName -Location $location

    # Assign the user as a contributor to the resource group
    New-AzRoleAssignment -ObjectId (Get-AzADUser -UserPrincipalName $contributorId).Id -RoleDefinitionName "Contributor" -ResourceGroupName $resourceGroupName
}