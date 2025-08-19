# WinPE Driver Management (HII) — Batch + PowerShell (PS2EXE)

Minimal toolkit to inject device drivers during **Ivanti/LANDESK provisioning** (WinPE or Windows).  
The PowerShell logic detects **vendor + model**, normalizes the name, then uses **DISM** to add drivers.

## Files in this repo
- **Hii.ps1** — PowerShell logic. Requires one parameter: `-path` (root folder of drivers).
- **Hii.exe** — Compiled from `Hii.ps1` using **PS2EXE**. Use this in **WinPE** when PowerShell isn’t present.
- **Hii.bat** — Simple wrapper to map a share and call `Hii.exe` (or `Hii.ps1`). Edit the drive letter and paths.

[Ivanti HII](https://blog.wuibaille.fr/2023/04/epm-hii-ps1-alternative-au-hii-ivanti/)
