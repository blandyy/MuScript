#!/bin/bash

echo "--------删除~/.ssh/known_hosts相应ip小工具--------"
KNOWN_PATH=~/.ssh/known_hosts
read -p "请输入你想删除的IP：
" ip
function get_line() {
    sed -n -e '/'$1'/=' $KNOWN_PATH
}
function get_context() {
    sed -n $1'p' $KNOWN_PATH
}
function del_all() {
    if [ "$(uname)" == "Darwin" ];then        # Mac OS X 操作系统
        sed -i "" '/'$1'/d' $KNOWN_PATH
    else                                    # 非Mac OS X默认为Linux
        sed -i '/'$1'/d' $KNOWN_PATH
    fi
}
function del_one() {
    if [ "$(uname)" == "Darwin" ];then        # Mac OS X 操作系统
        sed -i "" $1'd' $KNOWN_PATH
    else                                    # 非Mac OS X默认为Linux
        sed -i $1'd' $KNOWN_PATH
    fi
}
lines=$(get_line $ip)
if [ ! "$lines" ];then
    echo "没有找到该IP！"
    exit
fi
for i in $lines
do
    echo '查找到第 '$i' 行存在该IP，内容如下：'
    echo $(get_context $i)
done
read -p '请输入要删除的ip的行号 或者 输入all来删除所有匹配到的行：
' del_line
if [ ! "$del_line" ];then
    echo "输入不能为空！"
    exit
elif [ "$del_line" == "all" ];then
    del_all $ip
    if [ $? -eq 0 ]; then
        echo "success"
    else
        echo "fail"
        exit
    fi
else
    del_one $del_line
    if [ $? -eq 0 ]; then
        echo "success"
    else
        echo "fail"
        exit
    fi
fi
echo '0_0删除成功'