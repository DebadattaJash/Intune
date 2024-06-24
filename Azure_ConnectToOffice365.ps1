$host.ui.RawUI.WindowTitle = "GANNETT CLOUD"



Import-Module MSonline

$O365Cred = Get-Credential
$O365Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://pod51034psh.outlook.com/powershell-liveid?PSVersion=3.0 -Credential $O365Cred -Authentication Basic -AllowRedirection
Import-PSSession $O365Session -AllowClobber
Set-ExecutionPolicy Unrestricted
Connect-MsolService -Credential $O365Cred
#Import-Module LyncOnlineConnector
cls
Write-Host THIS IS FOR GANNETT!!!!!! -ForegroundColor Cyan