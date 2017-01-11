#!/bin/bash

function printHelp {
cat << EOF
isRoot          - Return "true" if user is root, else return "false".
    Example:
    # if [ $(isRoot) = "false" ]; then echo "You must be root, to execute this file!" 2>; fi
EOF
}

if [ $# -ne 0 ]; then
    printHelp;
    return 1;
fi

function isRoot {
    if [ ${EUID} == 0 ]; then
        echo "true";
    fi

    echo "false";
}
