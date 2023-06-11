@ECHO OFF
setlocal enabledelayedexpansion

:SETUP
set Energy=50
set dept=0
set house=0
set luck=1
Title Gambl
mode con: cols=60 lines=25
if NOT EXIST "Save.gamble" (
echo 10000> Save.gamble
goto SC
) else (
goto SC
)
:SC
<Save.gamble (
set /p gamble=
)
goto HOME

:DEAD
set Energy=50
set dept=0
set gamble=10000
set house=0
echo %gamble%> Save.gamble
cls
echo.
echo  Dead!
echo.
echo   Reasons of death could be.
echo.
echo  Starvation!
echo  Too much dept!
echo.
echo   Press any key to restart.
echo.
timeout /T 2 /NOBREAK >NUL
pause >NUL
goto HOME


:HOME
set /A Energy=%Energy% - 1
if "%Energy%"=="0" (
goto DEAD
) else if %dept% GEQ 250000 (
goto DEAD
) else (
echo.
)
cls
echo.
echo  HOME
echo.
echo  .gamble = %gamble%
echo  .energy = %Energy%
echo  .dept   = %dept%/250000
echo.
echo  1) Roll
echo  2) Work
echo  3) Shop
echo  4) Bank
echo  5) House
echo.
choice /C 12345I /N
if "%errorlevel%"=="1" (
goto ROLLCHECK
) else if "%errorlevel%"=="2" (
goto WORK
) else if "%errorlevel%"=="3" (
goto SHOP
) else if "%errorlevel%"=="4" (
goto BANK
) else if "%errorlevel%"=="5" (
goto HOUSE
) else if "%errorlevel%"=="6" (
goto DEV
)

:ROLLCHECK
if %gamble% GTR -1000 (
goto ROLL
) else (
cls
echo.
echo.
echo  You are too poor take a loan at the bank or go to work.
echo.
pause >NUL
goto HOME
)
:ROLL
cls
echo.
echo  Press any key to roll.
echo.
pause >NUL
set /A Mluck=%luck% * %luck%
set /A oldU=%RANDOM% %%18 +1
set /A uL=%oldU% + %Mluck%
set /A E=%RANDOM% %%36 +1
set /A G=%RANDOM% %%500 +1
set /A G=%G% + (%Mluck% * 200)
set /A L=%RANDOM% %%1000 +250
if %uL% GEQ %E% (
cls
echo.
echo  You win %G% gamble!
echo.
echo  You I %uL% I %E% I Enemy
echo.
echo  Press any key to return.
set /A gamble=!gamble! + !G!
echo !gamble!> Save.gamble
pause >NUL
set luck=1
goto HOME
) else (
cls
echo.
echo  You lose %L% gamble!
echo.
echo  You I %uL% I %E% I Enemy
echo.
echo  Press any key to return.
set /A gamble=!gamble! - !L!
echo !gamble!> Save.gamble
pause >NUL
goto HOME
)

:WORK
cls
echo.
echo   Press any key to work!
echo.
echo  Working.
echo.
pause >NUL
cls
echo.
echo   Press any key to work!
echo.
echo  Working..
echo.
pause >NUL
cls
echo.
echo   Press any key to work!
echo.
echo  Working...
echo.
pause >NUL
cls
echo.
echo   Press any key to work!
echo.
echo  Working.
echo.
pause >NUL
cls
echo.
echo   Press any key to work!
echo.
echo  Working..
echo.
pause >NUL
cls
echo.
echo  You gained 250 gamble!
echo.
echo  Press any key to return.
set /A gamble=%gamble% + 250
echo %gamble%> Save.gamble
pause >NUL
goto HOME

:SHOP
cls
echo.
echo  1) Theme : Red     I  10
echo  2) Theme : Green   I  10
echo  3) Theme : Blue    I  10
echo.
echo  L) Luck potion     I  2500
echo  F) Food            I  1000
echo  H) New House       I  595750
echo.
echo  B) Back
echo.
choice /C 123LFHB /N
if "%errorlevel%"=="1" (
set item=Color Red
set type=1
set ver=0C
set price=10
goto BUY
) else if "%errorlevel%"=="2" (
set item=Color Green
set type=1
set ver=0A
set price=10
goto BUY
) else if "%errorlevel%"=="3" (
set item=Color Blue
set type=1
set ver=09
set price=10
goto BUY
) else if "%errorlevel%"=="4" (
set item=Luck potion
set type=2
set price=2500
goto BUY
) else if "%errorlevel%"=="5" (
set item=Food
set type=3
set price=1000
goto BUY
) else if "%errorlevel%"=="6" (
set item=House
set type=4
set price=595750
goto BUY
) else if "%errorlevel%"=="7" (
goto HOME
) else (
goto HOME
)
goto HOME

:BUY
cls
echo.
echo  Are you sure that you want to but this item?
echo.
echo     %item% for %price%
echo.
echo   1) Yes
echo   2) No
echo.
choice /C 12 /N
if "%errorlevel%"=="1" (
if "%type%"=="1" (
if %gamble% GEQ %price% (
color %ver%
set /A gamble=%gamble% - %price%
echo !gamble!> Save.gamble
goto HOME
) else (
goto HOME
)
) else if "%type%"=="2" (
if %gamble% GEQ %price% (
set /A luck=%luck% + 1
set /A gamble=%gamble% - %price%
echo !gamble!> Save.gamble
goto HOME
) else (
goto HOME
)
) else if "%type%"=="3" (
if %gamble% GEQ %price% (
set /A Energy=%Energy% + 20
set /A gamble=%gamble% - %price%
echo !gamble!> Save.gamble
goto HOME
) else (
goto HOME
)
) else if "%type%"=="4" (
if %gamble% GEQ %price% (
set /A house=%house% + 1
set /A gamble=%gamble% - %price%
echo !gamble!> Save.gamble
goto HOME
) else (
goto HOME
)
)
) else if "%errorlevel%"=="2" (
goto HOME
)

:BANK
cls
echo.
echo.
echo   ___________
echo  / _________ \
echo  I I       I_I
echo  I I
echo  I I      ____
echo  I I_______II
echo  \__________I   BANK
echo.
echo.
echo   DEPT = %dept%
echo.
echo.
echo  1) Take loan
echo  2) Pay loan
echo  3) Back
echo.
choice /C 123 /N
if "%errorlevel%"=="1" (
goto TAKELOAN
) else if "%errorlevel%"=="2" (
goto PAYLOAN
) else if "%errorlevel%"=="3" (
goto HOME
)

:TAKELOAN
cls
echo.
echo.
echo   ___________
echo  / _________ \
echo  I I       I_I
echo  I I
echo  I I      ____
echo  I I_______II
echo  \__________I   BANK
echo.
echo.
echo.
echo   Take a loan and pay it back!
echo  Minimum = 250
echo  Maximum = 100000
echo.
set /p "loanammount=> "
if %loanammount% LSS 250 (
echo.
echo.
echo  The ammount you want to loan is too low.
echo.
pause >NUL
goto BANK
) else if %loanammount% GEQ 250 (
if %loanammount% LEQ 100000 (
set /A gamble=%gamble% + %loanammount%
set /A dept=%dept% + %loanammount%
echo !gamble!> Save.gamble
echo.
echo.
echo  Gamble transfered!
echo.
pause >NUL
goto BANK
) else (
echo.
echo.
echo  The ammount you want to loan is too high.
echo.
pause >NUL
goto BANK
)
) else (
goto BANK
)


:PAYLOAN
cls
echo.
echo.
echo   ___________
echo  / _________ \
echo  I I       I_I
echo  I I
echo  I I      ____
echo  I I_______II
echo  \__________I   BANK
echo.
echo.
echo.
echo  Paying loan...
echo.
echo.
set /A gamble=%gamble% - %dept%
set dept=0
echo !gamble!> Save.gamble
timeout /T 2 /NOBREAK >NUL
echo   Loan payed!
echo.
pause >NUL
goto HOME

:HOUSE
::https://www.asciiart.eu/buildings-and-places/houses::
cls
if "%house%"=="0" (
echo.
echo             ____.----.__
echo     ____.----'          \
echo     \                    \
echo      \                    \
echo       \          ____.----'`-__
echo        \___.----'          ^|   `--.____
echo       /`-._                ^|       .-' \
echo      /     `-._            ___.---'     \
echo     /          `-.____.---'              \
echo    /            / ^|                       \
echo   /            /  ^|\                 _.--'
echo   `-.         /   ^| \            __.--'
echo      `-._    /    ^|  \     __.--'     ^|
echo        ^| `-./     ^|   \_.-'           ^|
echo        ^|          ^|                   ^|
echo        ^|          ^|                   ^|
echo        ^|          ^|                   ^|
echo _______^|          ^|                   ^|_______________
echo        `-.        ^|                _.-'
echo           `-.     ^|           __..'
echo              `-.  ^|      __.-'
echo                 `-^|__.--'
echo.
echo.
) else if "%house%"=="1" (
echo.
echo    ____^|^|____
echo   ///////////\
echo  ///////////  \
echo  ^|    _    ^|  ^|
echo  ^|[] ^| ^| []^|[]^|
echo  ^|   ^| ^|   ^|  ^|
echo.
) else if "%house%"=="2" (
echo.
echo        _
echo      _^|=^|__________
echo     /     ----     \
echo    /   -     ---    \
echo   /__________________\
echo    ^|^|  ^|^| /--\ ^|^|  ^|^|
echo    ^|^|[]^|^| ^| .^| ^|^|[]^|^|
echo    ^|^|__^|^|_^|__^|_^|^|__^|^|
echo    ^|-^|-^|-^|~=~=^|-^|-^|-^| 
echo   --------------------
echo.
) else (
echo Welcome home.
)
pause >NUL
goto HOME

:DEV
cls
echo.
echo.
echo     DEV MENU
echo.
echo   VARS
echo  Energy      = %Energy%
echo  dept        = %dept%
echo  gamble      = %gamble%
echo  luck        = %luck%
echo  Mluck       = %Mluck%
echo  oldU        = %oldU%
echo  uL          = %uL%
echo  E           = %E%
echo  G           = %G%
echo  L           = %L%
echo  item        = %item%
echo  type        = %type%
echo  ver         = %ver%
echo  price       = %price%
echo  house       = %house%
echo  loanammount = %loanammount%
echo.
echo  changevarn   = %changevarn%
echo  changevars   = %changevars%
echo  gotowhere   = %gotowhere%
echo.
echo   CONSOLE
echo.
echo.
set /p "command=> "
if "%command%"=="!home" (
goto HOME
) else if "%command%"=="!help" (
echo.
echo.
echo   COMMANDS
echo.
echo  !home    - Goes back to home screen.
echo  !help    - Shows this message.
echo  !rich    - Gives you 99999 gamble.
echo  !die     - Kills you in game.
echo  !var     - Lets you manipulate variables.
echo  !goto    - Goes to any location you want.
echo  !git     - Opens the games github page.
echo  !credits - Shows the credits.
echo.
pause >NUL
goto DEV
) else if "%command%"=="!rich" (
set /A gamble=%gamble% + 99999
goto DEV
) else if "%command%"=="!die" (
goto DEAD
) else if "%command%"=="!var" (
goto DEVVAR
) else if "%command%"=="!goto" (
goto DEVGOTO
) else if "%command%"=="!git" (
start https://github.com
) else if "%command%"=="!credits" (
cls
echo.
echo   CREDITS
echo.
echo  Code ------------ Storm!
echo  House ASCII Art - https://www.asciiart.eu/buildings-and-places/houses
echo  Other ASCII Art - Storm!
echo.
pause >NUL
goto DEV
)
goto DEV

:DEVVAR
echo.
echo.
echo   VAR
echo.
echo  What variable do you want to change.
echo.
set /p "changevarn=> "
echo.
echo  What do you want to change %changevarn% to.
echo.
set /p "changevars=> "
echo.
echo  Changing %changevarn% to %changevars%
set %changevarn%=%changevars%
echo.
echo  Done!
echo.
pause >NUL
goto DEV

:DEVGOTO
echo.
echo.
echo   GOTO
echo.
echo  SETUP
echo  SC
echo  DEAD
echo  HOME
echo  ROLL
echo  WORK
echo  SHOP
echo  BUY
echo  BANK
echo  TAKELOAN
echo  PAYLOAN
echo  DEV
echo  DEVVAR
echo  DEVGOTO
echo.
set /p "gotowhere=> "
goto %gotowhere%
goto DEV


goto HOME