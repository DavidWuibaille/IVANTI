[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')

[xml]$XAML = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Add To Task" Height="500" Width="300"
        WindowStartupLocation="CenterScreen"
        Background="#FFFAFAFA">
    <Window.Resources>
        <Style TargetType="Label">
            <Setter Property="Margin" Value="10,5,10,0"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Foreground" Value="#FF444444"/>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Margin" Value="10,0,10,10"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Padding" Value="5"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Margin" Value="10,10,10,10"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="Background" Value="#FF1976D2"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="Bold"/>
        </Style>
    </Window.Resources>
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Label Content="Task ID:" Grid.Row="0" HorizontalAlignment="Left"/>
        <TextBox Name="TaskID" Grid.Row="1" HorizontalAlignment="Stretch"/>

        <Label Content="Computers:" Grid.Row="2" HorizontalAlignment="Left" VerticalAlignment="Top"/>
        <TextBox Name="PC" Grid.Row="2" VerticalAlignment="Top" AcceptsReturn="True" TextWrapping="Wrap" HorizontalAlignment="Stretch" Height="300"/>

        <Button Content="Add to Task" Name="Add" Grid.Row="3" HorizontalAlignment="Center" Width="150"/>
    </Grid>
</Window>
'@

# Credentials and Web Service Configuration
$mycreds = Get-Credential -Credential "monlab\david"
$webServiceURL = "https://epm.monlab.lan/MBSDKService/MsgSDK.asmx"

# Parse XAML
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $Form = [Windows.Markup.XamlReader]::Load($reader)
} catch {
    Write-Host "Unable to load Windows.Markup.XamlReader. Ensure .NET Framework is installed or PowerShell is running in STA mode."
    exit
}

# Assign Controls
$xaml.SelectNodes("//*[@Name]") | ForEach-Object {
    Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)
}

# Button Click Event Handler
$Add.Add_Click({
    if ($TaskID.Text -ne "") {
        $Task = $TaskID.Text

        # Initialize Web Service Proxy
        $ldWS = New-WebServiceProxy -Uri $webServiceURL -Credential $mycreds

        # Split and process computer names
        $ComputerList = $PC.Text -split "`r`n" | Where-Object { $_.Trim() -ne "" }

        foreach ($ComputerName in $ComputerList) {
            try {
                # Call Web Service to add device to scheduled task
                $ldWS.AddDeviceToScheduledTask($Task, $ComputerName.Trim())
                Write-Host "Successfully added: $ComputerName"
            } catch {
                Write-Host "Error adding $ComputerName : $_"
            }
        }
        Write-Host "Operation completed."
    } else {
        Write-Host "Error: Task ID cannot be empty."
    }
})

# Display the Form
$Form.ShowDialog() | Out-Null
