# Detect VBoot from Ivanti Provisioning Log

Small PowerShell helper that scans the Ivanti provisioning log and drops a **flag file** if **Vboot** is reported as successful.

- Reads: `C:\ldprovisioning\ProvisionGUI.exe.log`
- Looks for lines containing **both** `SUCCESS` and `Vboot`
- If found, creates: `C:\exploit\vbooton.flg` (with content `vboot`)

## Usage
Use this script during provisioning to detect whether **VBoot** was used (e.g., to trigger a reinstall workflow).  
Example:
```powershell
powershell -ExecutionPolicy Bypass -File .\detect-vboot.ps1