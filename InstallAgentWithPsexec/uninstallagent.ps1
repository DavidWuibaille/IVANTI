# Chemins vers les exécutables possibles
$path1 = "C:\Program Files (x86)\Ivanti\EPM Agent\epmagentinstaller.exe"
$path2 = "C:\Program Files\Ivanti\EPM Agent\epmagentinstaller.exe"
$uninstallExe = "UninstallWinClient.exe"

# Vérifier si le premier chemin existe
if (Test-Path $path1) {
    & "$path1" /forceuninstall
    Write-Host "Désinstallation lancée avec $path1"
}
# Sinon, vérifier le second chemin
elseif (Test-Path $path2) {
    & "$path2" /forceuninstall
    Write-Host "Désinstallation lancée avec $path2"
}
# Sinon, vérifier si UninstallWinClient.exe existe dans le même dossier que le script
elseif (Test-Path (Join-Path $PSScriptRoot $uninstallExe)) {
    & (Join-Path $PSScriptRoot $uninstallExe) /NOREBOOT
    Write-Host "Désinstallation lancée avec $uninstallExe"
}
else {
    Write-Host "Aucun désinstalleur approprié n'a été trouvé."
}
