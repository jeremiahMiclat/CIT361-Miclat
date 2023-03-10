class MAC {
    [string]$Address
    [string]$Vendor

    MAC([string]$Address) {
        # fixup the address to use colon format
        $this.Address = $Address.Replace('-', ':')
    }

    [string] MACVendorID() {
        return $this.Address.Split(':')[0..2] -join ':'
    }

    static [string] MACVendorID([string]$Address) {
        return $Address.Replace('-', ':').Split(':')[0..2] -join ':'
    }
}

function Get-MACVendor {
    [CmdletBinding()]
    param (
        [string]$DatabasePath = "$PSScriptRoot\MACDatabase.txt",
        [Parameter(Mandatory = $false)]
        [string]$MACAddress
    )

    # Check if the database file exists
    if (-not(Test-Path $DatabasePath)) {
        Throw "Database file not found: $DatabasePath"
    }

    # Load the database into an array
    $database = Get-Content $DatabasePath

    # to check os
    $os = (Get-WmiObject Win32_OperatingSystem).Caption

    # If a MAC address is supplied, find its vendor
    if ($MACAddress) {
        $mac = [MAC]::new($MACAddress)
        $line = $database | Select-String -Pattern $mac.Address | ForEach-Object { $_.Line.Split("`t") }

        if (!$line) {
            Write-Host "MAC address not in database: $($mac.Address)"
        }
        else {
            $Vendor = $line[1]
            $mac.Vendor = $Vendor
            return $mac
        }
    }
    else {
        # If no MAC address is supplied, get the MAC addresses of the network adapters

        if ($os.Contains('Windows')) {
            $adapters = Get-NetAdapter | Select-Object Name, MacAddress
            $macs = $adapters | ForEach-Object { $_.MacAddress }
            $macs = $macs | ForEach-Object { $_.Replace('-', ':') }
        }
        else {
            $macs = ifconfig -a | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | Select-Object -ExpandProperty MacAddress | Out-String      
        }

        # for debug
        # $macs = '00-00-00', '00-00-01', '00-00-02'
    

        # Find the vendor for each MAC address
        $macsAndVendors = $macs | ForEach-Object {
            $mac = [MAC]::new($_)

            $line = $database | Select-String -Pattern $mac.Address | ForEach-Object { $_.Line.Split("`t") }

            if (!$line) {
                $line = "MAC address not in database: $($mac.Address)"
            }
            else {
              
                $Vendor = $line[1]
                $mac.Vendor = $Vendor
                return $mac
            }
        }

        return $macsAndVendors
    }

    
}

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

# Get-MACVendor -DatabasePath C:\Users\nashw\OneDrive\Desktop\CIT361-Miclat\scripts\MACDatabase.txt -MACAddress 00:50:C2
