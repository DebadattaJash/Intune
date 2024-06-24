$moduleName = "Microsoft.Graph.Intune"
if (-not (Get-Module-ListAvailable -Name $moduleName)) {
    try {
        Install-Module-Name $moduleName -Scope CurrentUser -Repository PSGallery -Force
    }catch {
        Write-Error "Failed to install $moduleName"
        Exit
    }
}
Import-Module $moduleName