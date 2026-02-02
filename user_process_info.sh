#!/usr/bin/env bash
###############################################################################
# Script Name  : user_process_info.sh
# Description  : Displays the current user name and lists running processes.
#
# Author       : Suman Kafle
# Email        : sumankaflee@gmail.com
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x user_process_info.sh
#   ./user_process_info.sh
#
# Exit Codes   :
#   0  Success
#
# Notes        :
#   - Relies on the USER environment variable
#   - Uses standard `ps` utility available on most Linux systems
###############################################################################

#------------------------------------------------------------------------------
# Greet the current user
#------------------------------------------------------------------------------
echo "Hello ${USER}"

#------------------------------------------------------------------------------
# Inform the user about the upcoming process listing
#------------------------------------------------------------------------------
echo "Hey, I am ${USER} and will be telling you about the current processes."

#------------------------------------------------------------------------------
# Display running processes
#------------------------------------------------------------------------------
echo "Running processes list:"
ps
