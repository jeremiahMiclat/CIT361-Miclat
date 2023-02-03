<#
Program Name : color.ps1
Date: 28/01/2023
Author: Jeremiah Joseph Miclat
Corse: CIT361
I, Jeremiah Joseph Miclat, affirm that I wrote this script as original work completed by me.
#>

function getTimeDuration ($time) {
    $rt = "time duration is about "
    if ($round_time.Hours -gt 0) {
        $rt += $round_time.Hours
        $rt += "hours "
    }
    if ($round_time.Minutes -gt 0) {
        $rt += $round_time.Minutes
        $rt += "mins. "
    }
    if ($round_time.Seconds -gt 0) {
        $rt += $round_time.Seconds
        $rt += "sec. "
    }
    return $rt
    
}

$game_running = 'True'


while ($game_running -eq 'True') {
    Write-Host "Game Starts" -f Green
    

    $game_rounds = 1
    $rounds_won = 0
    $round_playing = 'True'
    $SystemColors = [System.Enum]::getvalues([System.ConsoleColor])
    $colors = 'Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White'
    do {
        $random_color = [String]($SystemColors | Get-Random)
        $round_color = $random_color
        $round_duration = ''
        $round_start = Get-Date
        $player_input = ''
        $guess_numbers = 0
        Write-Host "Round starts" -f Green
        Write-Host "Round number: $game_rounds"
        Write-Host "For dev purpose the round color is $round_color"
        Write-Host "The color pool is $colors"
        
        $hint = ''
        if ($round_color -like 'dark*') {
            $hint = 'Dark'
            $hint += $round_color.substring(4, 1)
        }
        else {
            $hint = $round_color.substring(0, 1)
        }
        
        Write-Host "Hint: $hint"
        
        $guessed = 'False'
        $guess_valid = 0

        
        
        do {

            <#while inpute invalid code start#>
            do {
                $player_guess = Read-Host "Enter your guess"
                $player_input = $player_guess
                if ($player_input -in $colors) {
                    <# Action to perform if the condition is true #>
                    $guess_valid = 1
                    $guess_numbers += 1
                }
                else {
                    $guess_valid = 0
                    Write-Host "Your input $player_input is invalid."
                }
            }
            until ($guess_valid -eq 1)
            <#while input invalid code end#>
        


            <#if color not guessed code start#>
       
            if ($round_color -ne $player_input) {
                Write-Host "Your answer " -nonewline
                Write-Host $player_input -f $player_input -nonewline
                Write-Host " is wrong"
                
                $prompt_to_continue = Read-Host "Enter 'y' or 'yes' to continue playing game"

                if (($prompt_to_continue -ne 'y' -and $prompt_to_continue -ne 'yes')) {
                    <# Action to perform if the condition is true #>
                    Write-Host "Round lost, can not continue this game #$game_rounds"  -f Red
                    $round_playing = 'False'                  
                    $round_end = Get-Date
                    $round_time = New-TimeSpan -Start $round_start -End $round_end
                    $round_duration = "Round "
                    $round_duration += getTimeDuration($round_time)
                    Write-Host $round_duration -f Cyan
                    Write-Host "Total number of guess this round: $guess_numbers. Total number of rounds played this game: $game_rounds" -f Cyan
                    Write-Host "Total rounds won this game: $rounds_won"
                    Write-Host "Round Ends" -f Red
                    $game_rounds += 1
                }
            }
            else {
                $guessed = 'True'
            }

            <#if color not guessed code end#>


        } until (
 
            $guessed -eq 'True' -or $round_playing -ne 'True'
        )




        <#if color is guessed code start#>
        # if ($round_color -eq $player_input) {
            
  
            
        # }

        if ($guessed -eq 'True') {
            <# Action to perform if the condition is true #>
            Write-Host "Your answer " -nonewline
            Write-Host $player_input -f $player_input -nonewline
            Write-Host " is correct"
            $round_end = Get-Date
            $round_time = New-TimeSpan -Start $round_start -End $round_end
            $round_duration = "Round "
            $round_duration += getTimeDuration($round_time)
            Write-Host $round_duration -f Cyan
            $prompt_to_continue = Read-Host "Enter 'y' or 'yes' to continue playing"

            if ($prompt_to_continue -ne 'y' -and $prompt_to_continue -ne 'yes') {
                <# Action to perform if the condition is true #>
                $round_playing = 'False'
            }
            $rounds_won += 1          
            Write-Host "Total number of guess this round: $guess_numbers. Total number of rounds played this game $game_rounds" -f Cyan
            Write-Host "Total rounds won this game: $rounds_won"
            Write-Host "Round Ends" -f Red
            $game_rounds += 1
        }
        <#if color is guessed code end#>


    
    
    } until (
        $round_playing -eq 'False'
    )

    $prompt_to_game = Read-Host "Enter 'y' or 'yes' to start a new game"

    if ($prompt_to_game -ne 'y' -and $prompt_to_game -ne 'yes') {
        <# Action to perform if the condition is true #>
        $game_running = 'False'
    }
}
Write-Host "Game Ends" -f Red

