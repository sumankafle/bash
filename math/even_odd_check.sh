#!/usr/bin/env bash
###############################################################################
# Script Name  : even_odd_check.sh
# Description  : Checks whether a given number is even or odd.
#                Accepts only non-zero integers and rejects characters/floats.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x even_odd_check.sh
#   ./even_odd_check.sh
#
# Exit Codes   :
#   0  Success
#   1  Invalid input
#
# Notes        :
#   - Only integer values are allowed
#   - Floating-point numbers and characters are rejected
###############################################################################

#------------------------------------------------------------------------------
# Function: is_integer
# Purpose : Validate signed or unsigned integer input (no floats, no chars)
#------------------------------------------------------------------------------
is_integer() {
    [[ $1 =~ ^-?[0-9]+$ ]]
}

#------------------------------------------------------------------------------
# Read user input
#------------------------------------------------------------------------------
echo -n "Enter a non-zero integer number: "
read -r number

#------------------------------------------------------------------------------
# Validate input: integer check
#------------------------------------------------------------------------------
if ! is_integer "${number}"; then
    echo "Error: Invalid input. Please enter an integer number only." >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Validate input: non-zero check
#------------------------------------------------------------------------------
if [[ "${number}" -eq 0 ]]; then
    echo "Error: Zero is not allowed." >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Check even or odd
#------------------------------------------------------------------------------
if (( number % 2 == 0 )); then
    echo "Result: ${number} is EVEN"
else
    echo "Result: ${number} is ODD"
fi
