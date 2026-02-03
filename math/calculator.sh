#!/usr/bin/env bash
###############################################################################
# Script Name  : calculator.sh
# Description  : Menu-driven calculator supporting integer and floating-point
#                arithmetic with input validation and error handling.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x calculator.sh
#   ./calculator.sh
#
# Exit Codes   :
#   0  Success
#   1  Invalid input or math error
#
# Requirements :
#   - Bash 4+
#   - bc (Basic Calculator)
###############################################################################

#------------------------------------------------------------------------------
# Enable safer Bash behavior
#------------------------------------------------------------------------------
set -o nounset
set -o pipefail

#------------------------------------------------------------------------------
# Function: is_number
# Purpose : Validate integer or floating-point input
#------------------------------------------------------------------------------
is_number() {
    [[ $1 =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

#------------------------------------------------------------------------------
# Function: read_number
# Purpose : Read and validate numeric input
#------------------------------------------------------------------------------
read_number() {
    local value
    read -r value

    if ! is_number "${value}"; then
        echo "Error: Invalid number '${value}'" >&2
        exit 1
    fi

    echo "${value}"
}

#------------------------------------------------------------------------------
# Display calculator menu
#------------------------------------------------------------------------------
cat <<EOF
=============================
        Bash Calculator
=============================

1. Addition
2. Subtraction
3. Multiplication
4. Division
5. Modulo
0. Quit

EOF

echo -n "Select an option [0-5]: "
read -r option

#------------------------------------------------------------------------------
# Quit option
#------------------------------------------------------------------------------
if [[ "${option}" == "0" ]]; then
    echo "Calculator exited."
    exit 0
fi

#------------------------------------------------------------------------------
# Read operands
#------------------------------------------------------------------------------
echo -n "Enter first number: "
num1="$(read_number)"

echo -n "Enter second number: "
num2="$(read_number)"

#------------------------------------------------------------------------------
# Perform calculation
#------------------------------------------------------------------------------
case "${option}" in
    1)
        result=$(echo "${num1} + ${num2}" | bc)
        operation="+"
        ;;
    2)
        result=$(echo "${num1} - ${num2}" | bc)
        operation="-"
        ;;
    3)
        result=$(echo "${num1} * ${num2}" | bc)
        operation="*"
        ;;
    4)
        # Division by zero check
        if echo "${num2} == 0" | bc -l | grep -q 1; then
            echo "Error: Division by zero is not allowed." >&2
            exit 1
        fi
        result=$(echo "scale=4; ${num1} / ${num2}" | bc -l)
        operation="/"
        ;;
    5)
        # Modulo only makes sense for integers
        if [[ "${num1}" == *.* || "${num2}" == *.* ]]; then
            echo "Error: Modulo supports integers only." >&2
            exit 1
        fi
        if [[ "${num2}" == "0" ]]; then
            echo "Error: Modulo by zero is not allowed." >&2
            exit 1
        fi
        result=$(echo "${num1} % ${num2}" | bc)
        operation="%"
        ;;
    *)
        echo "Error: Invalid option selected." >&2
        exit 1
        ;;
esac

#------------------------------------------------------------------------------
# Display result
#------------------------------------------------------------------------------
echo
echo "Result:"
echo "  ${num1} ${operation} ${num2} = ${result}"
