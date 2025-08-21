# 🔄 LANDESK Final Reboot Workaround

In some scenarios, the default **reboot task in LANDESK** cannot be used for the **final deployment reboot**, because the provisioning task only completes after a user logs back into the system.

---

## 🧩 Problem

- LANDESK provisioning tasks require a new session to complete.
- A standard reboot through LANDESK may interrupt the flow or fail to finalize properly.

---

## ✅ Workaround

To bypass this limitation, use `shutdown.exe` with a timeout longer than 30 seconds.

### 📝 Steps:

1. **Create a batch file** (e.g., `restart.cmd`) with the following line:

   ```cmd
   start c:\windows\system32\shutdown.exe /r /t 60 /c "Final restart"
   ```
2. Add this batch file to your LANDESK provisioning task. <BR>
Download <BR>
![reboot-01](https://blog.wuibaille.fr/wp-content/uploads/2024/04/reboot-01.png) <BR> <BR>
Execute <BR>
![reboot-01](https://blog.wuibaille.fr/wp-content/uploads/2024/04/reboot-01.png) <BR> <BR>
3. When the task reaches the reboot phase, it will trigger a delayed restart without closing the provisioning session prematurely.
The restart will be initiated at the end of the deployment after the provisioning task has completed properly.


