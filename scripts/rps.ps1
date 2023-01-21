<#
Program Name : rps.ps1
Date: 01/21/20023
Author: Jeremiah Joseph Miclat
Corse: CIT361
I, Jeremiah, affirm that I wrote this script as original work completed by me.
#>

$game_rounds = 0
$player_score = 0
$computer_score = 0
$is_game_over = 'False'

while ($is_game_over -eq 'False') {
    do {
        $game_rounds += 1
        Write-Host "Round $game_rounds" -ForegroundColor Yellow
        $random_item = 'rock', 'paper', 'sissors' | get-random #computer's pick
        $player_guess = 'invalid' #player's pick
        while ($player_guess -eq 'invalid' ) {
            $prompt = Read-Host 'Enter r for rock, p for paper, s for scissors'
            switch ($prompt) {
                'r' { $player_guess = 'rock' }
                'p' { $player_guess = 'paper' }
                's' { $player_guess = 'scissors' }
                default { 
                    $player_guess = 'invalid'
                    Write-Host 'Invalid input. Try again.' -ForegroundColor Red
                }
            }   
        }
        $updater = Write-Host "Player = $player_guess. Computer = $random_item" -ForegroundColor Blue
       
        if ($player_guess -eq $random_item) {
            $updater
            Write-Host "Round tied. Player-Computer score is $player_score - $computer_score"
        }
        elseif ($player_guess -eq 'rock') {
            if ($random_item -eq 'paper') {
                $computer_score += 1
                $updater
                Write-Host "Rock loses to Paper. You lose. Player-Computer score is $player_score - $computer_score"
            }
            else {
                $player_score += 1
                $updater
                Write-Host "Scissors can't cut Rock. You win. Player-Computer score is $player_score - $computer_score"
            }
        }
        elseif ($player_guess -eq 'paper') {
            if ($random_item -eq 'rock') {
                $player_score += 1
                $updater
                Write-Host "Rock loses to Paper.  You win. Player-Computer score is $player_score - $computer_score"
            }
            else {
                $computer_score += 1
                $updater
                Write-Host "Scissors can't cut Rock. You lose. Player-Computer score is $player_score - $computer_score"
            }
        }
        elseif ($player_guess -eq 'Scissors') {
            if ($random_item -eq 'rock') {
                $computer_score += 1
                $updater
                Write-Host "Scissors can't cut Rock. You lose. Player-Computer score is $player_score - $computer_score"
            }
            else {
                $player_score += 1
                $updater
                Write-Host "Scissors can cut Paper. You win. Player-Computer score is $player_score - $computer_score"
            }
        }
    
        Write-Host "`n"
    
        
    } until (
        <# Condition that stops the loop if it returns true #>
        $game_rounds -eq 3
    )
    
    Write-Host "`n"
    
    if ($player_score -gt $computer_score) {
        Write-Host 'Player won the game' -ForegroundColor Green
    }
    else {
        Write-Host 'Computer won the game' -ForegroundColor Green
    }
    $play_again = Read-Host 'Game Over. Enter "y" to play again'
 
    if ($play_again -eq 'y') {
        $game_rounds = 0
        $player_score = 0
        $computer_score = 0
    }
    else {
        $is_game_over = 'True'
    }
}