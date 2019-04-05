#!/bin/bash
LOCAL_PATH=$(cd `dirname $0`; pwd)
cd $LOCAL_PATH

backColor=0
# 字背景颜色范围:40----49 
# 40:黑 
# 41:深红 
# 42:绿 
# 43:黄色 
# 44:蓝色 
# 45:紫色 
# 46:深绿 
# 47:白色 
textColor=31
# 字颜色:30-----------39 
# 30:黑 
# 31:红 
# 32:绿 
# 33:黄 
# 34:蓝色 
# 35:紫色 
# 36:深绿 
# 37:白色 

helpText="用法：\n -c 提交日志\n -b 要推送的分支\n -h 帮助\n"


function printHelp(){
echo -e "\033[${backColor};${textColor}m $1 ${helpText} \033[0m"
}

if [ "$1" = "-h"  ];
then
printHelp
exit 1
fi

set -- `getopt c:b:h "$@"`

branch="master"

while [ -n "$1" ]
do
    case "$1" in 
     -c) commit=$2 
         shift ;;
     -b) branch=$2
         shift ;;
     -h) echo "found option h, no param." 
          ;;
#      --) printHelp ;;
#      *)  printHelp "参数错误！"
#         break ;;
    esac
    shift
done 

git add --all 
# git commit -am $commit
git commit
git push origin $branch