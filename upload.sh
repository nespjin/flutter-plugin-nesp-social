#!/bin/bash
LOCAL_PATH=$(cd `dirname $0`; pwd)
cd $LOCAL_PATH



if [  !"$1" ||  "$1" = "-h"  ];
then
echo -e "\033[背景颜色;字体颜色m字符串\033[0m"

fi


git add --all 
git commit -am $1
git push origin $2