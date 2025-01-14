# Import the required module
Import-Module MicrosoftPowerBIMgmt

# Authenticate to Power BI
Login-PowerBI

# Define the list of workspace names, their associated capacity IDs, and contributor IDs
$workspaceDetails = @(
    @{ WorkspaceName = "Student01"; CapacityName = "student01fabcc"; ContributorID = "Student01@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student02"; CapacityName = "student02fabcc"; ContributorID = "Student02@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student03"; CapacityName = "student03fabcc"; ContributorID = "Student03@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student04"; CapacityName = "student04fabcc"; ContributorID = "Student04@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student05"; CapacityName = "student05fabcc"; ContributorID = "Student05@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student06"; CapacityName = "student06fabcc"; ContributorID = "Student06@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student07"; CapacityName = "student07fabcc"; ContributorID = "Student07@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student08"; CapacityName = "student08fabcc"; ContributorID = "Student08@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student09"; CapacityName = "student09fabcc"; ContributorID = "Student09@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student10"; CapacityName = "student10fabcc"; ContributorID = "Student10@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student11"; CapacityName = "student11fabcc"; ContributorID = "Student11@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student12"; CapacityName = "student12fabcc"; ContributorID = "Student12@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student13"; CapacityName = "student13fabcc"; ContributorID = "Student13@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student14"; CapacityName = "student14fabcc"; ContributorID = "Student14@MngEnvMCAP316940.onmicrosoft.com" }
)

# Get the list of capacities
$capacities = Get-PowerBICapacity -Scope Organization

foreach ($ws in $workspaceDetails) {
    # Find the capacity by name
    $capacity = $capacities | Where-Object { $_.DisplayName -eq $ws.CapacityName }

    # If the capacity is found, create the workspace and assign it to the capacity
    if ($capacity) {
        $capacityId = $capacity.Id
        Write-Output "Capacity ID: $capacityId"

        # Create the workspace
        $workspace = New-PowerBIWorkspace -Name $ws.WorkspaceName

        # Add the user as a contributor to the workspace
        Add-PowerBIWorkspaceUser -Id $workspace.Id -UserPrincipalName $ws.ContributorID -AccessRight Contributor
    
        # Assign the workspace to the specified capacity
        Set-PowerBIWorkspace -Id $workspace.Id -CapacityId $capacityId -Scope Organization
    } else {
        Write-Output "Capacity not found."
    }
}