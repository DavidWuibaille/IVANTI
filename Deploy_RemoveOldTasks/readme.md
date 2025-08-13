# Cleanup Ivanti EPM Scheduled Tasks (SQL + MBSDK)

Deletes old Ivanti/LANDesk tasks based on **NEXT_START** age, then calls **MBSDK `DeleteTask()`**.  
Skips tasks with names containing **PORTAL** or **Download patch content**.  
Default retention **30 days** (tasks matching `*EN-BE*` use **2 days**).

## What it does
- Query: `LDMS.dbo.LD_TASK` via SQL.
- Compute days since `NEXT_START`.
- If `days > retention`, delete task via MBSDK.
- Console output shows task name, days, and deletions.

## Prerequisites
- Windows PowerShell 5.1+ / PowerShell 7+
- Network access to **SQL Server** and **MBSDK** endpoint
- SQL read access on `LDMS` (table `LD_TASK`)
- MBSDK account permitted to delete tasks

## Configure (edit in script)
- SQL: `$dataSource`, `$user`, `$PassSQL`, `$database`
- MBSDK URL & creds:
  - `New-WebServiceProxy -Uri http://server/MBSDKService/MsgSDK.asmx?WSDL`
  - `Get-Credential "domain\\user"`
- Retention rules:
  - Default: `$Retentionday = 30`
  - Special case: `if ($Nomtache -like "*EN-BE*") { $Retentionday = 2 }`
- Exclusions: names like `*PORTAL*`, `*Download patch content*`

## Usage
```powershell
powershell -ExecutionPolicy Bypass -File .\RemoveOldTask.ps1