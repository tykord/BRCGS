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
$CSVItems | Export-Csv -Path C:\data\TestObject.csv
