#!/bin/bash 

remote_host=${1}
remote_port=${2}
sleep_sec=${3:-10}
retry_cnt=${5:-5}
if [ $# -lt 2 ]; then
    echo "*** ERROR ****: Usage $(basename $0) <remote_host> <remote_port> [<wait-in-seconds for retry>] [<times-retry>]"
    exit
fi
shift 1

for v in {1..${retry_cnt}}; do
    echo "----------------------------------------------"
    sleep ${sleep_sec}
    nc -z ${remote_host} ${remote_port}
    if [ $? -ne 0 ]; then
        echo ">>> Status: FAIL: ${remote_host}:${remote_port}"
    else
        echo ">>> Status: -OK-: ${remote_host}:${remote_port}"
        exit 0
    fi
done
exit 1
