$dataSource = "InstanceBDD"
$user = "usrlandeskRead"
$PassSQL = 'password'
$database = "LDMS"
 
$connectionString = "Server=$dataSource;uid=$user; pwd=$PassSQL;Database=$database;Integrated Security=False;"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()
$query = "SELECT * FROM [LDMS].[dbo].[LD_TASK]"
$command = $connection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteReader()
$table = new-object System.Data.DataTable
$table.Load($result)
 
$currentdate = get-date
 
$mycreds = Get-Credential -Credential "domaine\dwuibail_adm"
$ldWS = New-WebServiceProxy -uri http://serverlandesk.leblogosd.lan/MBSDKService/MsgSDK.asmx?WSDL -Credential $mycreds
 
write-host "************************** list ask **************"
foreach ($element in $table) {
  $Nomtache = $element.TASK_NAME
  $next = $element.NEXT_START
  $taskid = $element.LD_TASK_IDN
 
  $Retentionday = 30
  If($Nomtache -like "*EN-BE*"){ $Retentionday = 2 }
 
  If(($Nomtache -notlike "*PORTAL*") -and ($Nomtache -notlike "*Download patch content*")){
    write-host $Nomtache
    if ($next -like "*/*") {
      $next = [DateTime]$next
 
      $ts = New-TimeSpan -Start $next -End $currentdate
      $nbday = $ts.Days
      write-host "Nombredejours=$nbday"
      if($nbday -gt $Retentionday) {
        Write-host "delete=$taskid" -ForegroundColor Yellow
        $ldWS.DeleteTask($taskid)
      }
    } Else {
      #Write-host "delete=$taskid" -ForegroundColor Yellow
    }
    write-host $next
    write-host " "
  }
}