<#
Program Name : network.ps1
Date: Feb. 9, 2023
Author: Jeremiah Joseph Miclat
Corse: CIT361
I, Jeremiah Joseph Miclat, affirm that I wrote this script as original work completed by me.
#>

function Get-IPNetwork {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $ipaddress,
        [Parameter()]
        [string]
        $subnetmask
    )
    process {
        try {
            $ip = [Net.IPAddress]$ipaddress
            $subnet = [Net.IPAddress]$subnetmask
            $netid = [Net.IPAddress]($ip.address -band $subnet.address)
            return $netid
        }
        catch {
            Write-Warning $Error[0]
        }
    }
}




function Test-IPNetwork {
    param (
        [Parameter()]
        [string]
        $ip1,
        [Parameter()]
        [string]
        $ip2,
        [Parameter()]
        [string]
        $subnetmask
    )
    process {
        try {
            $ipAddress1 = [Net.IPAddress]$ip1
            $ipAddress2 = [Net.IPAddress]$ip2
            $mask = [Net.IPAddress]$subnetmask
        ($ipAddress2.Address -band $mask.Address) -eq ($ipAddress1.Address -band $mask.Address)
        }
        catch {
            Write-Warning $Error[0]
        }
    }
}




$ip1 = Read-Host "Enter ip address" 
$ip2 = Read-Host "Enter another ip address" 
$subnetmask = Read-Host "Enter subnetmask"


$netid1 = Get-IPNetwork -ipaddress $ip1 -subnetmask $subnetmask
$netid2 = Get-IPNetwork -ipaddress $ip2 -subnetmask $subnetmask
$compareIP = Test-IPNetwork -ip1 $ip1 -ip2 $ip2 -subnetmask $subnetmask
Write-Host "$ip1 is in network $netid1"
Write-Host "$ip2 is in network $netid2"
Write-Host "IP addresses in the same network: $compareIP"