#Requires -Module MicrosoftPowerBIMgmt

Connect-PowerBIServiceAccount

$workspaces = @(
    @{ WorkspaceName = "Student01"; AdminID = "Student01@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student02"; AdminID = "Student02@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student03"; AdminID = "Student03@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student04"; AdminID = "Student04@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student05"; AdminID = "Student05@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student06"; AdminID = "Student06@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student07"; AdminID = "Student07@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student08"; AdminID = "Student08@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student09"; AdminID = "Student09@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student10"; AdminID = "Student10@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student11"; AdminID = "Student11@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student12"; AdminID = "Student12@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student13"; AdminID = "Student13@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student14"; AdminID = "Student14@MngEnvMCAP316940.onmicrosoft.com" },
    @{ WorkspaceName = "Student15"; AdminID = "Student15@MngEnvMCAP316940.onmicrosoft.com" }
)

# Loop through each user and assign them as Workspace Admin
foreach ($workspace in $workspaces) {
    $workspaceName = $workspace.WorkspaceName
    $adminID = $workspace.AdminID

    # Get the workspace
    $workspace = Get-PowerBIWorkspace -Name $workspaceName

    # Add the user as an admin to the workspace
    Add-PowerBIWorkspaceUser -Scope Organization -Id $workspace.Id -UserPrincipalName $adminID -AccessRight Admin
}