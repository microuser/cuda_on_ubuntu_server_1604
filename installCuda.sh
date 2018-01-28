#!/bin/sh

scriptExitCode=$((0))
autoStart=$(($1+0))

yesno=$(dialog --yesno 'install cuda' 80 5 --output-fd 1)


exityesno=$(dialog --yesno 'install cuda' 80 5 && echo 0 || echo 1)
echo $exityesno

MYVAR=$(dialog --inputbox "THIS OUTPUT GOES TO FD 1" 25 25  --output-fd 1)

