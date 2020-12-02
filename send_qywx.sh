#!/bin/bash


#set -xe

robot_key="you can get this key from WeCom"


if [[ -z $(which jq) ]]; then
    echo "jq is not installed. Run 'sudo yum install jq' to install it." >&2
    exit 1
fi


send_url="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=${robot_key}"
file_url="https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=${robot_key}&type=file"

function send_message {
        message="$1"
        body1='{"msgtype":"text","text":{"content":"'
        body2='"}}'
        body="${body1}${message}${body2}"

        curl ${send_url} \
           -H 'Content-Type: application/json' \
           -d "$body"
}

function send {
        send_message "$1"
        if [[ -z $2 ]]; then
                #echo "Do not need to send file"
                exit 0
        fi
        filename="$2"

        upload_result=`curl -F media=@${filename} ${file_url}`
        media_id=`echo ${upload_result} | jq ".media_id"`
        body1='{"msgtype":"file","file":{"media_id":'
        body2='}}'
        body="${body1}${media_id}${body2}"
        curl ${send_url} \
           -H 'Content-Type: application/json' \
           -d "$body"
}



#send_message $1
send "$1" "$2"