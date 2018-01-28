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

stillWhile=$((1)); while [[ "$stillWhile"  == $((1)) ]] && dialog --yesno "while dialog" 9 70   ; do
  
  sudo mkdir /usr/local/mine || exit 1
  sudo chmod 777 /usr/local/mine || exit 1
  cd /usr/local/mine || exit 1
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb || exit 1
  sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb || exit 1
  sudo apt-get update || exit 1
  sudo apt-get -y install cuda-8-0 || exit 1

  
  #stillWhile=$((0))
  break;
done;
echo doneing


