#!/bin/sh

#scriptExitCode=$((0))
#echo scriptExitCode:$scriptExitCode
#autoStart=$(($1+0))
#echo autostart:$autostart
#yesno=$(dialog --yesno 'install cuda' 9 70 --output-fd 1)
#echo yesno $yesno
#echo yesno $yesno

#exityesno=$(dialog --yesno 'install cuda' 9 70 && echo 0 || echo 1)
#echo exityesno $exityesno
#echo exityesno $exityesno

#MYVAR=$(dialog --inputbox "THIS OUTPUT GOES TO FD 1" 25 25  --output-fd 1)
#echo $MYVAR

while dialog --yesno "while dialog" 9 70 && false  ; do
  echo doing
done;
echo doneing


