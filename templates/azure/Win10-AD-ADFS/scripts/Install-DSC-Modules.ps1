#Requires -Version 5

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateSet("DC","ADFS","ADCS")]
    [string]$SetupType

)
Set-ExecutionPolicy Unrestricted -Force

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Install-Module -Name ActiveDirectoryDsc -RequiredVersion 6.0.1
Install-Module -Name NetworkingDsc -RequiredVersion 8.2.0
Install-Module -Name xPSDesiredStateConfiguration -RequiredVersion 9.1.0
Install-Module -Name ComputerManagementDsc -RequiredVersion 8.4.0

if ($SetupType -eq 'DC')
{
    Install-Module -Name xDnsServer -RequiredVersion 2.0.0
    Install-Module -Name xSmbShare -Force
    Install-Module -Name MSOnline -Force
    Install-Module -Name AzureAD -Force
    Install-Module -Name ActiveDirectoryCSDsc -RequiredVersion 5.0.0
    Install-Module -Name CertificateDsc -RequiredVersion 5.1.0
}
elseif ($SetupType -eq 'ADFS')
{
    Install-Module -Name AdfsDsc -RequiredVersion 1.1.0
}
elseif ($SetupType -eq 'ADCS')
{
    Install-Module -Name ADCSAdministration
}