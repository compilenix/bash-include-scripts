#!/bin/bash
function include { . "$(readlink -f $0)/include/$1.sh"; }

include "color";

function printHelp {
cat << EOF
  function_exists       - return true if function exist, else return false
EOF
}

function function_exists {
    declare -f -F $1 > /dev/null;
    return $?;
}
