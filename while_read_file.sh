#!/usr/bin/env bash
###############################################################################
# Script Name  : while_read_file.sh
# Description  : Reads a file line by line and prints each line prefixed
#                with an incrementing line number.
#
# Author       : Suman Kafle
# Email        : sumankaflee@gmail.com
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x while_read_file.sh
#   ./while_read_file.sh <input_file>
#
# Example      :
#   ./while_read_file.sh data.txt
#
# Exit Codes   :
#   0  Success
#   1  Invalid arguments or file not found
#
# Notes        :
#   - Uses `read -r` to preserve backslashes
#   - Avoids UUOC and subshells
#   - Compatible with Bash 4+
###############################################################################

#------------------------------------------------------------------------------
# Enable strict mode (modern best practice)
#------------------------------------------------------------------------------
set -Eeuo pipefail
IFS=$'\n\t'

#------------------------------------------------------------------------------
# Validate arguments
#------------------------------------------------------------------------------
if [[ $# -ne 1 ]]; then
    echo "Usage: $(basename "$0") <input_file>" >&2
    exit 1
fi

INPUT_FILE="$1"

if [[ ! -f "${INPUT_FILE}" ]]; then
    echo "Error: File not found: ${INPUT_FILE}" >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Initialize line counter
#------------------------------------------------------------------------------
count=0

#------------------------------------------------------------------------------
# Read file line by line
#------------------------------------------------------------------------------
while IFS= read -r line; do
    # Print line number and content
    printf "%d | %s\n" "${count}" "${line}"
    # Increment counter
    ((count++))
done < "${INPUT_FILE}"