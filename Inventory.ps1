$BIOS = Get-WmiObject -Class Win32_Bios
$OS = Get-WmiObject -class Win32_OperatingSystem
$PC = Get-WMIObject -class Win32_ComputerSystem
$RAM = [math]::Round((($PC.TotalPhysicalMemory/1024)/1024)/1024)
$CPU = Get-WmiObject -Class Win32_Processor

Write-Host "User Name:          ",$PC.UserName
Write-Host "Computer Name:      ",$OS.PSComputerName
Write-Host "Computer Make:      ",$PC.Manufacturer
Write-Host "Computer Model:     ",$PC.Model
Write-Host "Computer SN:        ", $BIOS.SerialNumber
Write-Host "CPU Installed:      ",$CPU.Name
Write-Host "CPU Core Count:     ",$CPU.NumberOfCores,"cores"
Write-Host "Installed RAM:      ",$RAM,"GB"
Write-Host "BIOS Release Date:  ",($BIOS.ConvertToDateTime($BIOS.releasedate).ToShortDateString())
Write-Host "OS Install Date:    ",($OS.ConvertToDateTime($OS.InstallDate).ToShortDateString())
Write-Host "OS Version:         ", $OS.Caption
Write-Host "OS Version:         ", $OS.Version


# Define Credentials
[string]$userName = 'brianwc@miltown.com'
[string]$userPassword = 'here'

# Crete credential Object
[SecureString]$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$credentialObejct = New-Object System.Management.Automation.PSCredential -ArgumentList $userName, $secureString

Send-MailMessage -From brianwc@miltown.com -to brianwc@miltown.com -subject "Inventory - BRCGS" -Body "Forgot to send the attachment. Sending now." -Attachments C:\DATA\GitHub\BRCGS\Inventory.ps1 -SmtpServer 'smtp.office365.com' -UseSsl -Credential $credentialObejct