#!/bin/bash
function include { . "$(readlink -f $0)/include/$1.sh"; }

include "color";
include "cursor.sh";

function printHelp {
cat << EOF
  evaluate_retval       - execute "echo_ok" or "echo_failure", depending on the last exit-code
  echo_ok               - Print a left aligned green OK sourrounded by brackets
  echo_failure          - Print a left aligned red FAIL sourrounded by brackets
  echo_warning          - Print a left aligned yellow WARN sourrounded by brackets
EOF
}

function echo_ok {
	extract_current_cursor_position currentPos;

	if [ ${currentPos[0]} -gt 0 ]; then
		echo;
	fi

	echo -n -e "${CURS_UP}${SET_COL}${BRACKET}[${SUCCESS}  OK  ${BRACKET}]"
	echo -e "${color_reset}"
	mesg_flush
}

function echo_failure {
	echo -n -e "${CURS_UP}${SET_COL}${BRACKET}[${FAILURE} FAIL ${BRACKET}]"
	echo -e "${color_reset}"
	mesg_flush
}

function echo_warning {
	echo -n -e "${CURS_UP}${SET_COL}${BRACKET}[${WARNING} WARN ${BRACKET}]"
	echo -e "${color_reset}"
	mesg_flush
}

function evaluate_retval {
	error_value="${?}"

	if [ ${error_value} = 0 ]; then
		echo_ok
	else
		echo_failure
	fi
}
