<#
Program Name : loop-da-loop.ps1
Date: 01/20/2023
Author: Jeremiah Joseph Miclat
Corse: CIT361
I, Jeremiah, affirm that I wrote this script as original work completed by me.
#> 

#Assign a string of your name to the $name variable
$name='Jeremiah'

Clear-Host
Write-Host "Beging output for $name" -ForegroundColor Green

#While loop that outputs the numbers 5-10  in the format of 'Number #'
'While 5-10';'=' * 80
#Your code Here
$n = 5
while ($n -lt 11) {
    Write-Host "Number $n"
    $n++
}

#Do While loop that outputs the numbers from 100-150 counting by 10 in the format 'Number #'
'';'Do while 100-150 by 10s';'=' * 80
#Your code Here
$n = 90
do {
    $n+=10
    Write-Host "Number $n"
} while (
    <# Condition that stops the loop if it returns false #>
    $n -lt 149
)

#Do Until loop that outputs the numbers from 1000 to 1500 counting by 100 in the format 'Number #'
'';'Do until 1000-1500 by 100s';'=' * 80
#Your code Here
$n=900
do {
    $n+=100
    Write-Host "Number $n"
} until (
    <# Condition that stops the loop if it returns true #>
    $n -eq 1500
)

#For loop that outputs the numbers from -5 to -10  in the format 'Number #'
'';'For -5 to -10';'=' * 80
#Your code Here
for ($i = -5; $i -gt -11; $i--){
    #Action that will repeat until the condition is met #>
    Write-Host "Number $i"
}

#Foreach loop that gets a list of files from the current directory and outputs the name and size in KB
'';'Foreach directory';'=' * 80
#Your code Here
$path = Get-Location
$directory = get-childitem $path
foreach ($_ in $directory) {
    Write-Host $_.name ("{0:n2}" -f ((Get-Item $_).Length/1kb))kb
}

#Any loop that outputs the numbers from 1 to 10 skipping every third number using continue in the format 'Number #'
'';'Continue 1 to 10 skipping every third number';'=' * 80
#Your code Here
foreach ($i in 1..10) {
    if ($i%3-eq0) {
        continue
    }
    Write-Host $i
}
Write-Host "This concludes the output for $name" -ForegroundColor Green