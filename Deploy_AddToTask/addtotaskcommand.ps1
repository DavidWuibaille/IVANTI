<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">Param(
    [parameter(Mandatory=$true)][String]$FichierCSV,
    [parameter(Mandatory=$true)][String]$TaskID
)

$mycreds = Get-Credential -Credential "mydomain\myaccount"
$ldWS = New-WebServiceProxy -uri http://myserverurl.domain.lan/MBSDKService/MsgSDK.asmx?WSDL -Credential $mycreds

$CSV = Get-Content $FichierCSV
foreach ($line in $CSV) {
    $ldWS.AddDeviceToScheduledTask($TaskID, $line)
}</pre>
<!-- /wp:syntaxhighlighter/code -->
