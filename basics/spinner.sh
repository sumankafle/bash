#!/usr/bin/env bash
###############################################################################
# Script Name  : spinner.sh
# Description  : Displays a simple terminal spinner animation to indicate
#                that a background task or process is running.
#
# Author       : Suman Kafle
# Email        : sumankaflee@gmail.com
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x spinner.sh
#   ./spinner.sh
#
# Exit Codes   :
#   0  Success (terminated manually with Ctrl+C)
#
# Notes        :
#   - Runs indefinitely until interrupted
#   - Uses carriage return for in-place terminal updates
#   - Compatible with Bash 4+
###############################################################################

#------------------------------------------------------------------------------
# Spinner characters (displayed in sequence)
#------------------------------------------------------------------------------
SPINNER_CHARS=('-' '\' '|' '/')

#------------------------------------------------------------------------------
# Infinite loop to animate spinner
#------------------------------------------------------------------------------
while true; do
    for c in "${SPINNER_CHARS[@]}"; do
        # Print spinner character without newline, overwrite same line
        echo -en "\r ${c} "
        sleep 0.5
    done
done
