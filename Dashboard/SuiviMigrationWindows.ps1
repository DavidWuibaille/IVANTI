############################################### SQL ################################################################
$Exporthtml = "C:\temp\default.htm"
$ServerSQL = "epm2024.monlab.lan"
$database = "EPM"
$user = "sa"

# Best solution with password encrypt
#$password = ConvertTo-SecureString -String "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#$creds    = New-Object -TypeName System.Management.Automation.PsCredential -ArgumentList ($user, $password)

# bad solution with visible password
$password = "Password1"
$creds = New-Object -TypeName System.Management.Automation.PsCredential -ArgumentList ($user, (ConvertTo-SecureString -String $password -AsPlainText -Force))
$PassSQL = $creds.GetNetworkCredential().Password
############################################### SQL ################################################################


Import-Module -Name PSwriteHTML
. ([scriptblock]::Create((Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DavidWuibaille/Repository/main/Function/DashboardEPM.ps1" -UseBasicParsing).Content))

# Sauvegarde quotidienne des versions Windows
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$historyFile = Join-Path -Path $scriptPath -ChildPath "windows_versions_history.csv"
$today = (Get-Date -Format "yyyy-MM-dd")

$todayData = $WindowsgroupesVersion | ForEach-Object {
    [PSCustomObject]@{
        Date    = $today
        Version = $_.Name
        Count   = $_.Count
    }
}

if (-Not (Test-Path $historyFile)) {
    $todayData | Export-Csv -Path $historyFile -NoTypeInformation -Encoding UTF8
} else {
    $existingData = Import-Csv $historyFile
    $newEntries = $todayData | Where-Object {
        $version = $_.Version
        -Not ($existingData | Where-Object { $_.Date -eq $today -and $_.Version -eq $version })
    }
    if ($newEntries) {
        $newEntries | Export-Csv -Path $historyFile -Append -NoTypeInformation -Encoding UTF8
    }
}

# Génération des courbes temporelles
$history = Import-Csv -Path $historyFile
$versions = $history.Version | Sort-Object -Unique
$dates = $history.Date | Sort-Object -Unique

$lines = foreach ($version in $versions) {
    $valeurs = foreach ($date in $dates) {
        ($history | Where-Object { $_.Date -eq $date -and $_.Version -eq $version }).Count | Measure-Object -Sum | Select-Object -ExpandProperty Sum
    }
    [PSCustomObject]@{
        Version = $version
        Values  = $valeurs
    }
}

# Préparer les données groupées par version majeure (ex: 19044)
$historyGrouped = $history | ForEach-Object {
    $_ | Add-Member -NotePropertyName "MajorVersion" -NotePropertyValue ($_.Version -split '\.')[0] -Force
    $_
}

$majorVersions = $historyGrouped.MajorVersion | Sort-Object -Unique

$versionLabels = @{
    "14393" = "Windows 10 1607"
    "17763" = "Windows 10 1809"
    "19044" = "Windows 10 21H2"
    "20348" = "Windows Server 2022"
    "22621" = "Windows 11 22H2"
    "22631" = "Windows 11 23H2"
}


$linesMajor = foreach ($version in $majorVersions) {
    $valeurs = foreach ($date in $dates) {
        ($historyGrouped | Where-Object { $_.Date -eq $date -and $_.MajorVersion -eq $version }).Count | Measure-Object -Sum | Select-Object -ExpandProperty Sum
    }

    [PSCustomObject]@{
        Version = $versionLabels[$version] | ForEach-Object { if ($_ -ne $null) { $_ } else { $version } }
        Values  = $valeurs
    }
}

# Rapport HTML
New-HTML -TitleText 'Dashboard' {

    # Onglet Windows - Donut chart actuel
    New-HTMLTab -Name 'Windows' {
        New-HTMLSection -HeaderText 'Windows Version' {
            New-HTMLPanel {
                New-HTMLChart -Title "Version" {
                    New-ChartToolbar -Download
                    New-ChartEvent -DataTableID 'WindowsOS' -ColumnID 1
                    foreach ($groupe in $WindowsgroupesVersion) {
                        New-ChartDonut -Name $($groupe.Name) -Value $($groupe.Count)
                    }
                }
            }
        }
        New-HTMLSection -Invisible {
            New-HTMLPanel {
                New-HTMLTable -DataTable $WindowsDetails -DataTableID 'WindowsOS' -HideFooter
            }
        }
    }

    # Onglet Timeline - Évolution dans le temps
    New-HTMLTab -Name 'Windows Timeline' {
        New-HTMLSection -HeaderText 'Windows Versions Over Time' {
            New-HTMLPanel {
                New-HTMLChart -Title "Windows Versions (Daily Evolution)" -TitleAlignment center {
                    New-ChartAxisX -Names $dates
                    foreach ($line in $lines) {
                        New-ChartLine -Name $line.Version -Value $line.Values
                    }
                }
            }
        }
# Deuxième graphique en-dessous
New-HTMLSection -HeaderText 'Windows Versions Over Time (Grouped by Major Version)' {
    New-HTMLPanel {
        New-HTMLChart -Title "Windows Major Versions (Daily Evolution)" -TitleAlignment center {
            New-ChartAxisX -Names $dates
            foreach ($line in $linesMajor) {
                New-ChartLine -Name $line.Version -Value $line.Values
            }
        }
    }
}		
		
    }

    # Onglet Hardware
    New-HTMLTab -Name 'Model' {
        New-HTMLSection -HeaderText 'Hardware' {
            New-HTMLPanel {
                New-HTMLChart -Title "Version" {
                    New-ChartToolbar -Download
                    New-ChartEvent -DataTableID 'Modelcount' -ColumnID 1
                    foreach ($groupe in $Modelscount) {
                        New-ChartDonut -Name $($groupe.Name) -Value $($groupe.Count)
                    }
                }
            }
        }
        New-HTMLSection -HeaderText 'Models details' {
            New-HTMLTable -DataTable $WorkstationModels -DataTableID 'Modelcount' -HideFooter {
                "<H1>Models Details</H1>"
            }
        }
    }

    # Pied de page
    New-HTMLFooter {
        New-HTMLText -Text "Date of this report (GMT time): $(Get-Date)" -Color Blue -Alignment Center 
    }

} -FilePath $Exporthtml -Online
