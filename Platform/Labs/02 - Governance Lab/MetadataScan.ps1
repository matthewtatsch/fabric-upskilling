#Install MicrosoftPowerBIMgmt module
Install-Module -Name MicrosoftPowerBIMgmt

#Login
Login-PowerBIServiceAccount

#Build URL to exclude Personal Workspaces
$url = "https://api.powerbi.com/v1.0/myorg/admin/workspaces/modified?excludePersonalWorkspaces=True"
#Get list of workspaces
Invoke-PowerBIRestMethod -Url $url -Method Get | ConvertFrom-Json

#Build URL to start a scan against a workspace or set of workspaces. Replace the workspace ID in the $body variable from the result of the above command
$url1 = "https://api.powerbi.com/v1.0/myorg/admin/workspaces/getInfo"
$body = @"
{
 "workspaces": [
    "YOUR WORKSPACES"
 ]
}
"@

#Trigger a scan
Invoke-PowerBIRestMethod -Url $url1 -Body $body  -Method Post | ConvertFrom-Json

#Poll to check if the scan shows status as Succeeded
$poll = "https://api.powerbi.com/v1.0/myorg/admin/workspaces/scanStatus/YOUR SCAN ID"
Invoke-PowerBIRestMethod -Url $poll  -Method Get | ConvertFrom-Json

# Get the result of the scan
$scanresult = "https://api.powerbi.com/v1.0/myorg/admin/workspaces/scanResult/YOUR SCAN ID"
Invoke-PowerBIRestMethod -Url $scanresult  -Method Get

#Incremental Scans
#Get the createdDateTIme from the output of the command that triggered the scan

#Build URL to exclude look for modified workspaces and also exclude Personal Workspaces
$WorkspacesModifiedSince = "https://api.powerbi.com/v1.0/myorg/admin/workspaces/modified?modifiedSince=<Last Modified Time>Z&excludePersonalWorkspaces=True"
Invoke-PowerBIRestMethod -Url $WorkspacesModifiedSince  -Method Get | ConvertFrom-Json