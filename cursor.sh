#!/bin/bash

function printHelp {
cat << EOF
  extract_current_cursor_position       - first parameter used as destination variable
  Usage:
    example, to save current cursor position in pos1
    # extract_current_cursor_position pos1;
    To see cursor positions saved in pos1
    # echo ${pos1[0]} ${pos1[1]};
    To move/restore cursor position to pos1
    # tput cup ${pos1[0]} ${pos1[1]};
EOF
}

if [ $# -ne 0 ]; then
    printHelp;
    return 1;
fi

function extract_current_cursor_position {
    export $1;
    exec < /dev/tty;
    oldstty=$(stty -g);
    stty raw -echo min 0;
    echo -en "\033[6n" > /dev/tty;
    IFS=';' read -r -d R -a pos;
    stty $oldstty;
    eval "$1[0]=$((${pos[1]} - 1))";
    eval "$1[1]=$((${pos[0]:2} - 2))";
}
