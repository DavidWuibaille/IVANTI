# Retrieve the Preferred Server Based on the IP Address

![GetMyPreferedServer Screenshot](https://blog.wuibaille.fr/wp-content/uploads/2024/04/GetMyPreferedServer.png)

This script allows you to **identify the preferred server** for a device, based on its **IP address**, by querying a central SQL database.

---

## 🔧 Configuration

Before using the script, update the following lines with your SQL connection details:

```powershell
$dataSource = "InstanceSQL"
$user       = "SQLAccount"
$PassSQL    = "SQLPassword"
$database   = "DatabaseName"
```

Make sure the account has permission to query the relevant table containing IP/server associations