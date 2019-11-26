#/bin/bash
dir="/home/wwwroot/"
deepwise_www="/home/wwwroot/deepwise-www"
#backup old environment
if [ -d $deepwise_www ];then
        cd $dir && mv deepwise-www deepwise-www_`date +%Y_%m_%d-%H:%M:%S`
else
        echo "$deepwise: no such directory"
        exit 1
fi

