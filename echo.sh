#!/bin/bash
function include { . "$(readlink -f $0)/include/$1.sh"; }

include "color";
include "cursor";

function printHelp {
cat << EOF
  runAndEcho            - do a shell-exec / -eval on the first parameter and after that run evaluate_retval
  evaluate_retval       - execute "echo_ok" or "echo_failure", depending on the last exit-code, first parameter is used as message text
  echo_ok               - Print a left aligned green OK sourrounded by brackets, first parameter is used as message text
  echo_failure          - Print a left aligned red FAIL sourrounded by brackets, first parameter is used as message text
  echo_warning          - Print a left aligned yellow WARN sourrounded by brackets, first parameter is used as message text
EOF
}

if [ $# -ne 0 ]; then
    printHelp;
    return 1;
fi

function echoFixCurrentPos {
    extract_current_cursor_position currentPos;

    if [ ${currentPos[0]} -gt 0 ]; then
        echo;
    fi
}

function echoStatus {
    statusText=$1;
    color=$2;
    message=$3;

    printf "${color_bblue}[${color}${statusText}${color_bblue}]${color_reset}${message}\n";
}

function echo_ok {
    echoFixCurrentPos;
    echoStatus "  OK  " "${color_bgreen}" "$1";
}

function echo_failure {
    echoFixCurrentPos;
    echoStatus " FAIL " "${color_bred}" "$1";
}

function echo_warning {
    echoFixCurrentPos;
    echoStatus " WARN " "${color_byellow}" "$1";
}

function echo_info {
    echoFixCurrentPos;
    echoStatus " INFO " "${color_bwhite}" "$1";
}

function evaluate_retval {
    error_value="${?}";

    if [ ${error_value} = 0 ]; then
        echo_ok "$1";
    else
        echo_failure "$1";
    fi
}

function runAndEcho {
    commandToRun="$1";

    eval "$commandToRun";
    evaluate_retval "$commandToRun";
}
