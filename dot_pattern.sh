#!/usr/bin/env bash
###############################################################################
# Script Name  : dot_pattern.sh
# Description  : Prompts the user for a number between 5 and 9 and prints
#                a symmetric dot pyramid pattern on the terminal.
#
# Author       : Suman Kafle
# Email        : sumankaflee@gmail.com
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x dot_pattern.sh
#   ./dot_pattern.sh
#
# Exit Codes   :
#   0  Success
#   1  Invalid user input
#
# Notes        :
#   - Requires Bash (uses C-style for-loops)
#   - Input must be an integer between 5 and 9 (inclusive)
###############################################################################

#------------------------------------------------------------------------------
# Enable safer Bash behavior (modern best practice)
#------------------------------------------------------------------------------
set -o nounset
set -o errexit
set -o pipefail

#------------------------------------------------------------------------------
# Initialize variable
#------------------------------------------------------------------------------
MAX_NO=0

#------------------------------------------------------------------------------
# Prompt user for input
#------------------------------------------------------------------------------
echo -n "Enter a number between (5 to 9): "
read -r MAX_NO

#------------------------------------------------------------------------------
# Validate user input
#------------------------------------------------------------------------------
if ! [[ "${MAX_NO}" -ge 5 && "${MAX_NO}" -le 9 ]]; then
    echo "Error: Please enter a valid number between 5 and 9."
    exit 1
fi

#------------------------------------------------------------------------------
# Clear the terminal for clean output
#------------------------------------------------------------------------------
clear

#------------------------------------------------------------------------------
# First stage: Upper half of the dot pyramid
#------------------------------------------------------------------------------
for ((i = 1; i <= MAX_NO; i++)); do
    # Print leading spaces
    for ((s = MAX_NO; s >= i; s--)); do
        echo -n " "
    done

    # Print dots
    for ((j = 1; j <= i; j++)); do
        echo -n " ."
    done

    # New line after each row
    echo
done

#------------------------------------------------------------------------------
# Second stage: Lower half of the dot pyramid
#------------------------------------------------------------------------------
for ((i = MAX_NO; i >= 1; i--)); do
    # Print leading spaces
    for ((s = i; s <= MAX_NO; s++)); do
        echo -n " "
    done

    # Print dots
    for ((j = 1; j <= i; j++)); do
        echo -n " ."
    done

    # New line after each row
    echo
done

#------------------------------------------------------------------------------
# Final message
#------------------------------------------------------------------------------
echo -e "\nWhenever you need help, Tecmint.com is always there"
