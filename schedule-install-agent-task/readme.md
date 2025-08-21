# 🔄 IVANTI EPM Agent Reinstallation via Scheduled Task

When migrating from an old IVANTI EPM agent to a new version, a direct redeployment using IVANTI itself is not always possible or reliable.

This method provides a workaround using a **scheduled task**, deployed via IVANTI, that installs the new agent after reboot.

---

## 🧩 How It Works

### 📁 Files Included

- **CreateTask.ps1**  
  Creates a scheduled task that runs after reboot (with a 5-minute delay). This script is deployed via IVANTI.

- **InstallIvantiAgent.ps1**  
  The script executed by the scheduled task. It:
  - Downloads the new agent installer from a **web share** (preferably hosted on the Core Server)
  - Installs the new agent
  - Deletes the scheduled task once done

- **DeleteTask.ps1** *(optional)*  
  Can be used to manually remove the scheduled task if needed.

---
## ⚙️ Configuration

Before using the script, make sure to configure the following variables in `InstallIvantiAgent.ps1`:

```powershell
$baseUrl = "http://epm2024.monlab.lan/share/ivanti/agent/"
$fileNames = @(
    "d3873a1c.0",
    "EPM_Manifest",
    "EPMAgentInstaller.exe",
    "EPM2024Agent.txt"
)
$hostName = "epm2024.monlab.lan"
```
$baseUrl must point to the web share where your IVANTI agent files are hosted (preferably on the Core Server).

$fileNames should include all required files for the agent installation.

$hostName is used for validation or connection checks and should match your Core Server’s hostname.

---

## 🚀 Deployment Steps

1. Use IVANTI to push `CreateTask.ps1` to the target machine.
2. After the next reboot, `InstallIvantiAgent.ps1` runs via the scheduled task.
3. The agent is reinstalled and the task is removed automatically.

---

## 💡 Recommendations

- Host the agent installer and `InstallIvantiAgent.ps1` on a web share accessible from all target machines.
- Make sure the scheduled task runs with appropriate permissions.

---

## 📘 Tip

This method avoids issues caused by trying to overwrite or update the agent while it is running, ensuring a cleaner migration process.
