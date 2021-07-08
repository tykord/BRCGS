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

Send-MailMessage -From brianwc@miltown.com -to brianwc@sunnyoasis.com -subject Test