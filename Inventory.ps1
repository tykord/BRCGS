Set-ExecutionPolicy -ExecutionPolicy Unrestricted -force -verbose
$BIOS = Get-WmiObject -Class Win32_Bios
$OS = Get-WmiObject -class Win32_OperatingSystem
$PC = Get-WMIObject -class Win32_ComputerSystem
$RAM = [math]::Round((($PC.TotalPhysicalMemory/1024)/1024)/1024)
[string]$Random = 'X^#1kd950ajRGHzvnWMqlD$Pd*DBW9HBU*fJ7pZ6yOxX8otmQ&aV9xT'
$CPU = Get-WmiObject -Class Win32_Processor
$CPUCore = $CPU.NumberOfCores
$CSVItems = [PSCustomObject]@{
    UserName = $PC.UserName;
    ComputerName = $OS.PSComputerName;
    ComputerMake = $PC.Manufacturer;
    ComputerModel = $PC.Model;
    ComputerSN =  $BIOS.SerialNumber;
    CPUInstalled = $CPU.Name;
    CPUCoreCount = $CPUCore;
    InstalledRAM = $RAM;
    BIOSReleaseDate = ($BIOS.ConvertToDateTime($BIOS.releasedate).ToShortDateString());
    OSInstallDate= ($OS.ConvertToDateTime($OS.InstallDate).ToShortDateString());
    OSVersion =  $OS.Caption;
    OSVer =  $OS.Version
}
New-Item -Path c:\temp -ItemType directory -Force
$CSVItems | Export-Csv -Path C:\temp\TestObject.csv
[string]$email = 'inventory@tykord.com'
$Subject = "Inventory - " + $PC.username
$body = "This is the sytem inventory of " + $OS.PSComputerName + " generated by " + $PC.username
[SecureString]$secureString = $Random | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$credentialObejct = New-Object System.Management.Automation.PSCredential -ArgumentList $email, $secureString
Send-MailMessage -From inventory@tykord.com -to brianwc@miltown.com -subject $Subject -Body $body -Attachments C:\temp\TestObject.csv -SmtpServer 'smtp.office365.com' -UseSsl -Credential $credentialObejct -verbose
Set-ExecutionPolicy -ExecutionPolicy Default -Force -verbose
