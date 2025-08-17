# Hyper-V Guest Script Runner (GUI)

Run a `.ps1` inside one or more “Running” Windows VMs via PowerShell Direct.  
Scripts are listed from `https://nas.wuibaille.fr/WS/postype/`.

## Features
- Auto-discover running VMs on the local Hyper-V host
- Fetch available `.ps1` scripts from the URL above
- Enter guest credentials once, run on multiple VMs
- Optional `gpupdate /force` after the script
- Inline log (download status, script exit code, gpupdate exit code)

## Prerequisites
- Host: Windows 10/11 with Hyper-V role + Hyper-V PowerShell module
- Run PowerShell as Administrator on the host
- Guests: Windows 10/11 (or Server 2016+) in “Running” state with an admin account (e.g., `.\Administrator`)
- Guests must reach `https://nas.wuibaille.fr` (HTTPS) to download the script
- PowerShell Direct works only from the **same** Hyper-V host that runs the VMs

## File & Config
Script: `Invoke-GuestScript-GUI.ps1`  
At the top of the file:
```powershell
$BaseUrl = 'https://nas.wuibaille.fr/WS/postype/'