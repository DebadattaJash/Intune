# US DOMAIN CONTROLLER ent-mocadbh01.us.ad.gannett.com
# PNI DOMAIN CONTROLLER pni-pocaddc02.pni.us.ad.gannett.com
# INI DOMAIN CONTROLLER ini-mocaddc01.ini.us.ad.gannett.com
# USAT DOMAIN CONTROLLER usat-mocadbh01.usatoday.us.ad.gannett.com

Import-Module activeDirectory

$fqdn = Read-Host "ini.us.ad.gannett.com"
$cred = Get-Credential

Write-Host "Contacting $fqdn domain..." -ForegroundColor Yellow

$domain = (get-addomain $fqdn -Credential $cred | select distinguishedName,pdcEmulator,DNSroot,DomainControllersContainer)

Write-Host "Completed. Enumerating OUs.." -ForegroundColor Yellow

$OUlist = @(Get-ADOrganizationalUnit -filter * -Credential $cred -SearchBase $domain.distinguishedName -SearchScope OneLevel -Server $domain.DNSroot)
Write-Host "Completed. Counting users..." -ForegroundColor Yellow

for($i = 1; $i -le $oulist.Count; $i++)
    {write-progress -Activity "Collecting OUs" -Status "Finding OUs $i" -PercentComplete ($i/$OUlist.count*100)}
$newlist = @{}



foreach ($_objectitem in $OUlist)
    {
    $getUser = Get-ADuser -Filter * -Credential $cred -SearchBase $_objectItem.DistinguishedName -SearchScope Subtree -Server $domain.pdcEmulator | measure | select Count
    for($i = 1; $i -le $getUser.Count; $i++)
    {write-progress -Activity "Counting users" -Status "Finding users $i in $_objectitem" -PercentComplete ($i/$getUser.count*100)}
    
    $newlist.add($_objectItem.Name, $getUser.Count)    
    }

 $newlist > .\OUuserCount.txt 

 Write-Host "All done!" -ForegroundColor yellow 
 
