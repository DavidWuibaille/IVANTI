# 🧠 Sysnative Usage in 32-bit Scripts on 64-bit Windows

This script demonstrates how to correctly call **64-bit system executables** from a **32-bit process**, using the special Windows path alias: `Sysnative`.

---

## 🧩 Why Use `Sysnative`?

When a 32-bit process runs on a 64-bit Windows system, Windows **redirects** calls to `System32` to `SysWOW64`, which contains 32-bit versions of executables.

To access the **actual 64-bit system files** from a 32-bit context (like in a 32-bit CMD or installer), you must use `Sysnative`.

---

## ⚙️ What This Script Does

It checks if the script is running in a 32-bit context on a 64-bit system:

```bat
if defined PROCESSOR_ARCHITEW6432
Set cmdreg=%SystemRoot%\sysnative\reg.exe
Set cmdpowershell=%SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe
Set cmddism=%SystemRoot%\Sysnative\cmd.exe /c Dism
...
```
These variables are then used to:

- Modify registry keys with 64-bit reg.exe
- Run 64-bit PowerShell scripts
- Install drivers with 64-bit DISM
- Change power settings, run wusa, etc.

📘 **Tip**

Only use `Sysnative` when running 32-bit scripts on 64-bit Windows.  
If your script runs in a 64-bit context, `System32` already points to the correct location.