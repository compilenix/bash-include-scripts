#!/bin/bash

# example, to save current cursor position in pos1, use:
# extract_current_cursor_position pos1;
# To see cursor positions saved in pos1, you can use:
# echo ${pos1[0]} ${pos1[1]};
# To move/restore cursor position to pos1, you have to use:
# tput cup ${pos1[0]} ${pos1[1]};
function extract_current_cursor_position {
    export $1;
    exec < /dev/tty;
    oldstty=$(stty -g);
    stty raw -echo min 0;
    echo -en "\033[6n" > /dev/tty;
    IFS=';' read -r -d R -a pos;
    stty $oldstty;
    eval "$1[0]=$((${pos[0]:2} - 2))";
    eval "$1[1]=$((${pos[1]} - 1))";
}
