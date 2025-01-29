#Requires -Modules Az, MicrosoftPowerBIMgmt

##################################
## Azure Resource Group Cleanup ##
##################################

Write-Output "Cleaning up Azure Resources..."

# List of Azure Resource Groups to delete
$resourceGroups = @(
    "fabric-admin-rg",
    "fabric-student01-rg",
    "fabric-student02-rg",
    "fabric-student03-rg",
    "fabric-student04-rg",
    "fabric-student05-rg",
    "fabric-student06-rg",
    "fabric-student07-rg",
    "fabric-student08-rg",
    "fabric-student09-rg",
    "fabric-student10-rg",
    "fabric-student11-rg",
    "fabric-student12-rg",
    "fabric-student13-rg",
    "fabric-student14-rg",
    "fabric-student15-rg"
)

# Login to Azure
# Connect-AzAccount

# Loop through each Resource Group and delete it
foreach ($rg in $resourceGroups) {
    try {
        Remove-AzResourceGroup -Name $rg -Force -ErrorAction Stop
        Write-Output "Successfully deleted Resource Group: $rg"
    } catch {
        Write-Output "Failed to delete Resource Group: $rg. Error: $_"
    }
}

################################
## Power BI Workspace Cleanup ##
################################

Write-Output "Cleaning up Power BI Workspaces..."

# Use the student IDs to identify the workspaces to delete
$workspaceAdmins = @(
    "Student01@MngEnvMCAP316940.onmicrosoft.com",
    "Student02@MngEnvMCAP316940.onmicrosoft.com",
    "Student03@MngEnvMCAP316940.onmicrosoft.com",
    "Student04@MngEnvMCAP316940.onmicrosoft.com",
    "Student05@MngEnvMCAP316940.onmicrosoft.com",
    "Student06@MngEnvMCAP316940.onmicrosoft.com",
    "Student07@MngEnvMCAP316940.onmicrosoft.com",
    "Student08@MngEnvMCAP316940.onmicrosoft.com",
    "Student09@MngEnvMCAP316940.onmicrosoft.com",
    "Student10@MngEnvMCAP316940.onmicrosoft.com",
    "Student11@MngEnvMCAP316940.onmicrosoft.com",
    "Student12@MngEnvMCAP316940.onmicrosoft.com",
    "Student13@MngEnvMCAP316940.onmicrosoft.com",
    "Student14@MngEnvMCAP316940.onmicrosoft.com",
    "Student15@MngEnvMCAP316940.onmicrosoft.com"
)

# Connect to Power BI
# Connect-PowerBIServiceAccount

# Get the workspaces where the specified users are admins
$workspaces = Get-PowerBIWorkspace -Scope Organization -Type Workspace | Where-Object { 
    $_.Users | Where-Object { 
        $_.AccessRight -eq "Admin" -and $workspaceAdmins -contains $_.UserPrincipalName 
    } 
}

# Loop through each workspace and delete it
foreach ($workspace in $workspaces) {
    $workspaceId = $workspace.Id
    $workspaceName = $workspace.Name

    $workspaceId = $workspace.Id

    # Delete the workspace using the REST API
    $url = "https://api.powerbi.com/v1.0/myorg/groups/$workspaceId"
    try {
        Invoke-PowerBIRestMethod -Url $url -Method Delete
        Write-Output "Successfully deleted workspace: $workspaceName"
    } catch {
        Write-Output "Failed to delete workspace: $workspaceName. Error: $_"
        continue
    }
}
