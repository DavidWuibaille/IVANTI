# Remove Old Scheduled Tasks (Ivanti EPM)
Deletes outdated **scheduled tasks** from Ivanti EPM based on the next run date in `LD_TASK`, with simple name-based exclusions, via MBSDK (`MsgSDK.asmx`).

## Requirements
- Windows PowerShell 5.1
- Read access to SQL database `LDMS` (table `dbo.LD_TASK`)
- Network access to the EPM Core MBSDK endpoint
- Account permitted to delete tasks via MBSDK

## Configure (top of script)
```powershell
$dataSource = "InstanceBDD"            # SQL Server/instance
$user       = "usrlandeskRead"         # SQL read-only login
$PassSQL    = "password"               # SQL password
$database   = "LDMS"                    # Database

$mycreds = Get-Credential -Credential "domaine\\dwuibail_adm"  # EPM account
$ldWS    = New-WebServiceProxy -Uri "http://serverlandesk.leblogosd.lan/MBSDKService/MsgSDK.asmx?WSDL" -Credential $mycreds
```

## Behavior
Loads dbo.LD_TASK and iterates tasks:
-- Default retention: 30 days
-- Skips names matching *PORTAL* and *Download patch content*

When NEXT_START is older than retention, calls:
-- $ldWS.DeleteTask($taskid)


## Run
```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Remove-OldScheduledTasks.ps1
```