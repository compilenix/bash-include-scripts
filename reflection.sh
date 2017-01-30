#!/bin/bash
function include { . "$(dirname $(readlink -f ${0}))/${1}.sh"; }

include "color";

function printHelp {
cat << EOF
  function_exists       - return true if function exist, else return false
EOF
}

case "$1" in
    "help"|"--help"|"-h"|"h")
        printHelp;
        return 0;
    ;;
esac

function function_exists {
    declare -f -F $1 > /dev/null;
    return $?;
}
