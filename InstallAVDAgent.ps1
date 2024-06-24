$AgentInstaller = "C:\temp\AVD\Microsoft.RDInfra.RDAgent.Installer-x64-1.0.6129.9100.msi"
$AgentBootServiceInstaller = "C:\temp\AVD\Microsoft.RDInfra.RDAgentBootLoader.Installer-x64.msi"

#AVD Agent command
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $AgentInstaller", "/quiet", "/qn", "/norestart", "/passive", "REGISTRATIONTOKEN=$PoolToken", "/l* C:\MuP-Digital\AgentInstall.txt" -Wait -Passthru

#Bootloader command
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $AgentBootServiceInstaller", "/quiet", "/qn", "/passive", "/l* C:\MuP-Digital\AgentBootLoaderInstall.txt" -Wait -Passthru


