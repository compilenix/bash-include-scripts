#!/bin/bash

function printHelp {
cat << EOF
Return "true" if user is root, else return "false".
EOF
}

function isRoot {
	if [ $# -ne 0 ]; then
		printHelp;
		return 1;
	fi

	if [ ${EUID} == 0 ]; then
		echo "true";
	fi

	echo "false";
}
