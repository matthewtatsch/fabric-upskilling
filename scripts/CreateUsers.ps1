#Requires -Module Microsoft.Graph

Connect-MgGraph -Scopes "User.ReadWrite.All"

# Function to generate a random password
function Generate-RandomPassword {
    $length = 12
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
    -join ((65..90) + (97..122) + (48..57) + (33..47) | Get-Random -Count $length | ForEach-Object { [char]$_ })
}

# Get the path to the CSV file in the same directory as the script
$csvPath = Join-Path -Path $PSScriptRoot -ChildPath "users.csv"

# Import users from CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Generate the random password
    $randomPassword = Generate-RandomPassword

    # Define the user parameters
    $UserParams = @{
        DisplayName       = $user.DisplayName
        MailNickName      = $user.MailNickName
        UserPrincipalName = $user.UserPrincipalName
        PasswordProfile   = @{
            Password                             = $randomPassword
            ForceChangePasswordNextSignIn        = $true
            ForceChangePasswordNextSignInWithMfa = $true
        }
        AccountEnabled    = $true
    }

    # Create the user
    New-MgUser @UserParams

    # Print the username and password
    Write-Output "UserPrincipalName: $($user.UserPrincipalName)"
    Write-Output "Password: $randomPassword"
}