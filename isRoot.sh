#!/bin/bash

function printHelp {
cat << EOF
isRoot          - Return "true" if user is root, else return "false".
    Example:
    # if [ \$(isRoot) = "false" ]; then echo "You must be root, to execute this file!" 2>; fi
EOF
}

case "$1" in
    "help"|"--help"|"-h"|"h")
        printHelp;
        return 0;
    ;;
esac

function isRoot {
    if [[ ${EUID} -eq 0 ]]; then
        echo "true";
        return 0;
    fi

    echo "false";
    return 0;
}
