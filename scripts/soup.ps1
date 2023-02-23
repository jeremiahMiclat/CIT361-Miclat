function Get-Soup {
    <#
     .SYNOPSIS
     Tell something about soup input
     .Description
     Something about soup
     .Example
     Get- Soup Fish Bowl 5
     Soup Chicken Cup 2
     #>
    [Alias('Soup')]
    param(
        [Parameter(Mandatory = $true)]
        $soup,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Cup', 'Bowl', 'Pot')]
        $size,
        [ValidateRange(1, 5)]
        $Quantity = 1,
        [switch]$Please
    )

    if ($Please) {
        "$Quantity $size$(if($Quantity -gt 1){'s'}) of $soup soup for you."
    }
    else {
        "No $soup for you!"
    }
}
