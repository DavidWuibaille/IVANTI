# Check EPM Package Files — README

Validate that **Ivanti EPM** package file references exist (HTTP/HTTPS and UNC).  
The script connects to SQL, reads `[dbo].[PACKAGE]` and `[dbo].[PACKAGE_FILES_HASH]`, and reports missing files.

## Requirements
- Windows PowerShell 5.1
- Network access to SQL (`EPM2021` DB in the sample)
- SQL account with read access to `dbo.PACKAGE` and `dbo.PACKAGE_FILES_HASH`

## Configure
Edit these variables at the top of the script:
```powershell
$dataSource = "sql.leblogosd.lan"   # SQL Server / instance
$user       = "compteSQL"           # SQL login
$PassSQL    = "Password"            # SQL password (plaintext in sample)
$database   = "EPM2021"             # EPM database
```
## What it does
- SELECT * FROM dbo.PACKAGE and SELECT * FROM dbo.PACKAGE_FILES_HASH
- For each package/file hash:
-- If FULL_PATH starts with http → Invoke-WebRequest (200 = OK, else MISSING)
-- If FULL_PATH starts with \\ → Test-Path on UNC (exists = OK, else MISSING)

## What it does
```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Check-EpmPackageFiles.ps1
```