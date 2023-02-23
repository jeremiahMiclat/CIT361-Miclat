#!/usr/bin/pwsh
<#
Program Name : remotehello.ps1
Date: 5/2/2020
Author: Craig Lindstrom
Corse: CIT361
I, Craig Lindstrom, affirm that I wrote this script as original work completed by me.
#> 

param($name='')
if([string]::IsNullOrWhiteSpace($name)){
    "Hi class, today is $((get-date).toshortdatestring())."
}else{
    "Hi $name, today is $((get-date).toshortdatestring())."
}
if($IsCoreCLR){"You are running on PowerShell Core smartypants."}
if($IsLinux){"Not only that you are running on Linux"}
if($IsMacOS){"Not only that you are running on OSX"}
