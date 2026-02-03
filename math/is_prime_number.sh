#!/usr/bin/env bash
###############################################################################
# Script Name  : is_prime_number.sh
# Description  : Checks whether a given number is a prime number.
#                Accepts only positive integers greater than 1.
#                Rejects zero, one, floating-point numbers, and characters.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x is_prime_number.sh
#   ./is_prime_number.sh
#
# Exit Codes   :
#   0  Success
#   1  Invalid input or non-prime number
###############################################################################

#------------------------------------------------------------------------------
# Function: is_integer
# Purpose : Validate integer input (no characters, no floats)
#------------------------------------------------------------------------------
is_integer() {
    [[ $1 =~ ^-?[0-9]+$ ]]
}

#------------------------------------------------------------------------------
# Read user input
#------------------------------------------------------------------------------
echo -n "Enter a positive integer (> 1): "
read -r number

#------------------------------------------------------------------------------
# Validate integer input
#------------------------------------------------------------------------------
if ! is_integer "${number}"; then
    echo "Error: Input must be an integer (no characters or decimals)." >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Reject numbers less than or equal to 1
#------------------------------------------------------------------------------
if (( number <= 1 )); then
    echo "Error: Number must be greater than 1." >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Prime number check
#------------------------------------------------------------------------------
is_prime=true

for (( i = 2; i * i <= number; i++ )); do
    if (( number % i == 0 )); then
        is_prime=false
        break
    fi
done

#------------------------------------------------------------------------------
# Output result
#------------------------------------------------------------------------------
if [[ "${is_prime}" == true ]]; then
    echo "Result: ${number} is a PRIME number"
else
    echo "Result: ${number} is NOT a prime number"
    exit 1
fi
