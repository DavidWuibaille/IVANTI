# Documentation

Script to Add or Remove IP Ranges on a Preferred Server

This script does not directly add IP ranges to preferred servers but generates the SQL commands to do so.


##Usage Example

```powershell
RemoveAllIP -NamePreferedServer "epm2021.leblogosd.lan"
AddIP -NamePreferedServer "epm2021.leblogosd.lan" -IPadressStart "192.168.0.1" -IPadressEnd "192.168.0.254"
RemoveIP -NamePreferedServer "epm2021.leblogosd.lan" -IPadressStart "192.168.0.1" -IPadressEnd "192.168.0.254"
```