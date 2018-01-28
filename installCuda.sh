#!/bin/sh

scriptExitCode=$((0))
autoStart=$(($1+0))

yesno=$(dialog --yesno 'install cuda' 9 70 --output-fd 1)
echo $yesno
echo $yesno

exityesno=$(dialog --yesno 'install cuda' 9 70 && echo 0 || echo 1)
echo $exityesno
echo $exityesno

MYVAR=$(dialog --inputbox "THIS OUTPUT GOES TO FD 1" 25 25  --output-fd 1)
echo $MYVAR
