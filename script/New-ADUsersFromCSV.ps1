# New-ADUsersFromCSV.ps1
# Creates Active Directory users from a CSV file

param(
    [string]$CSVPath = ".\users2.csv"
)

# Import the CSV
$users = Import-Csv -Path $CSVPath

foreach ($user in $users) {

    $sam = $user.Username
    $given = $user.FirstName
    $surname = $user.LastName
    $ou = $user.OU

    try {
        New-ADUser `
            -SamAccountName $sam `
            -GivenName $given `
            -Surname $surname `
            -Name "$given $surname" `
            -AccountPassword (ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force) `
            -Enabled $true `
            -Path $ou `
            -ErrorAction Stop

        Write-Host "Created AD user: $sam"
    }
    catch {
        Write-Host "Failed to create user $sam"
    }
}