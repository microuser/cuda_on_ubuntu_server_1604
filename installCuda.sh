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

  sudo apt-get install -y xorg || exit 1
  touch xorg.conf || exit 1
  
  #cat /etc/X11/xorg.conf | tee /etc/X11/xorg.conf`date +%s` || exit 1
  #sudo nvidia-xconfig -a --cool-bits=28 --allow-empty-initial-configuration  || exit 1
  
  dialog --infobox "xorg before `date`" 9 70
  cat /etc/X11/xorg.conf | sudo tee /etc/X11/xorg.conf`date +%s` || exit 1
  #sudo nvidia-xconfig -a  --cool-bits=28 --allow-empty-initial-configuration --enable-all-gpus || exit 1
  
  cat > ~/gpufansetting << 'EOF'
#!/bin/bash
    #a delay can be specified on the command line if not used from termonal session
    DEFAULT_DELAY=0
    if [ "x$1" = "x" -o "x$1" = "xnone" ]; then
     DELAY=$DEFAULT_DELAY
    else
     DELAY=$1
    fi
    sleep $DELAY
    #write log file for debugging
    exec 2> /tmp/gpufansetting.log
    exec 1>&2
    set -x
    #make sure an Xorg server is running which you can connect to
    # ":1" can be any unused display number.
    # there may be better ways using an already running server, but this works.
    #more on targets: https://www.systutorials.com/239880/change-systemd-boot-target-linux/
    #not tested: isolate could be the better way than using set-default!
    echo 'set default graphical target'
    systemctl set-default graphical.target
    echo starting x
    X :1 &
    echo sleeping 10
    sleep 10
    export DISPLAY=:1
    #set GPU 0..5 fan to 100%. (This assumes six GPUs)
    nvidia-settings -a [gpu:0]/GPUFanControlState=1 -a [fan-0]/GPUTargetFanSpeed=100
    #nvidia-settings -a [gpu:1]/GPUFanControlState=1 -a [fan-1]/GPUTargetFanSpeed=100
    #nvidia-settings -a [gpu:2]/GPUFanControlState=1 -a [fan-2]/GPUTargetFanSpeed=100
    #nvidia-settings -a [gpu:3]/GPUFanControlState=1 -a [fan-3]/GPUTargetFanSpeed=100
    #nvidia-settings -a [gpu:4]/GPUFanControlState=1 -a [fan-4]/GPUTargetFanSpeed=100
    #nvidia-settings -a [gpu:5]/GPUFanControlState=1 -a [fan-5]/GPUTargetFanSpeed=100
    #set back to command line prompt after boot (optional)
    sudo systemctl set-default multi-user.target
    #terminating Xorg will reset fan speeds to default so do not terminate Xorg!
    #sudo killall Xorg
    #from remote terminal
    env DISPLAY=:1 nvidia-settings -a [gpu:0]/GPUFanControlState=1 -a [fan-0]/GPUTargetFanSpeed=89
    #from remote terminal
    sudo nvidia-settings -c :1 -a [gpu:0]/GPUFanControlState=1 -a [fan-0]/GPUTargetFanSpeed=89
    sleep 2
    nvidia-smi
  
    nvidia-settings -q fans
EOF

  sudo mv ~/gpufansetting /usr/local/bin/gpufansetting
  sudo chmod +x /usr/local/bin/gpufansetting
  dialog --infobox "fpugansetting" 9 70
  cat /usr/local/bin/gpufansetting
  
  dialog --infobox "xorg after `date`" 9 70
  cat /etc/X11/xorg.conf | sudo tee /etc/X11/xorg.conf`date +%s` || exit 1
  
  
  break;
done

