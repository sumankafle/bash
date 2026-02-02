#!/usr/bin/env bash
###############################################################################
# Script Name  : system_info_menu.sh
# Description  : Menu-driven system information utility that allows the user
#                to view system details, disk usage, and home directory usage.
#
# Author       : Suman Kafle
# Email        : sumankaflee@gmail.com
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x system_info_menu.sh
#   ./system_info_menu.sh
#
# Exit Codes   :
#   0  Success
#   1  Invalid menu selection
#
# Notes        :
#   - Requires Bash
#   - Uses standard Linux utilities: uptime, df, du
#   - Root users can view disk usage for all home directories
###############################################################################

#------------------------------------------------------------------------------
# Enable safer Bash behavior (modern best practice)
#------------------------------------------------------------------------------
set -Eeuo pipefail
IFS=$'\n\t'

#------------------------------------------------------------------------------
# Clear the terminal for a clean menu display
#------------------------------------------------------------------------------
clear

#------------------------------------------------------------------------------
# Display menu options using a here-document
#------------------------------------------------------------------------------
cat <<EOF
Please Select:

    1. Display System Information
    2. Display Disk Space
    3. Display Home Space Utilization
    0. Quit

EOF

#------------------------------------------------------------------------------
# Prompt user for menu selection
#------------------------------------------------------------------------------
echo -n "Enter selection [0-3]: "
read -r sel

#------------------------------------------------------------------------------
# Process user selection
#------------------------------------------------------------------------------
case "${sel}" in
    0)
        echo "Program terminated."
        ;;
    1)
        # Display system hostname and uptime
        echo "Hostname: ${HOSTNAME}"
        uptime
        ;;
    2)
        # Display disk usage in human-readable format
        df -h
        ;;
    3)
        # Display home directory disk usage
        if [[ "${UID}" -eq 0 ]]; then
            echo "Home Space Utilization (All Users)"
            du -sh /home/*
        else
            echo "Home Space Utilization (${USER})"
            du -sh "${HOME}"
        fi
        ;;
    *)
        # Handle invalid menu selections
        echo "Invalid entry." >&2
        exit 1
        ;;
esac
