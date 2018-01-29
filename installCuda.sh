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

shouldInstallCuda8=`dialog --yesno && $((1)) || $((0)`
echo installCuda:$installCuda

if [[ $shouldInstallCuda == $((1)) ]] ; then
  echo shouldInstallCuda
fi



while dialog --yesno "install cuda" 9 70   ; do
  
  
  
  
  sudo rm -Rfv /usr/local/cudaRepo || exit 1
  sudo mkdir -p /usr/local/cudaRepo || exit 1
  sudo chmod 777 /usr/local/cudaRepo || exit 1
  cd /usr/local/cudaRepo || exit 1
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb || exit 1
  sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb || exit 1
  sudo apt-get update || exit 1
  sudo apt-get -y install cuda-8-0 || exit 1
  
  #stillWhile=$((0))
  break;
done;
echo doneing

#while [[ "$stillWhile"  == $((1)) ]] && dialog --yesno "while dialog" 9 70   ; do
while dialog --yesno "configure xorg" 9 70   ; do

  sudo apt-get install -y xorg
  touch xorg.conf || exit 1
  
  #cat /etc/X11/xorg.conf | tee /etc/X11/xorg.conf`date +%s` || exit 1
  #sudo nvidia-xconfig -a --cool-bits=28 --allow-empty-initial-configuration  || exit 1
  
  dialog --infobox "xorg before `date`" 9 70
  cat /etc/X11/xorg.conf | tee /etc/X11/xorg.conf`date +%s` || exit 1
  sudo nvidia-xconfig -a  --cool-bits=28 --allow-empty-initial-configuration --enable-all-gpus || exit 1
  dialog --infobox "xorg after `date`" 9 70
  cat /etc/X11/xorg.conf | tee /etc/X11/xorg.conf`date +%s` || exit 1
  
  
  break;
done

