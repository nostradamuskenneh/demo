#!/bin/bash
    USER=${User}
    cat permission.txt |grep -i $User
    if 
    [[ $? -eg 0 ]]
    then 
    echo "you have permission to run this job"
    else
    echo "you don't have permission to run this job"
    exit 1
    fi
