#!/usr/bin/env bash
###############################################################################
# Script Name  : greet_user.sh
# Description  : Interactively asks the user for their first and last name
#                and prints a personalized greeting and farewell message.
#
# Author       : Suman Kafle
# Email        : sumankaflee@gmail.com
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x greet_user.sh
#   ./greet_user.sh
#
# Exit Codes   :
#   0  Success
#
# Notes        :
#   - Uses standard input via `read`
#   - Compatible with Bash 5+
#   - Uses /usr/bin/env for better portability
###############################################################################

#------------------------------------------------------------------------------
# Prompt user for first name
#------------------------------------------------------------------------------
echo "Hey, what's your first name?"
read -r first_name

#------------------------------------------------------------------------------
# Prompt user for last name
#------------------------------------------------------------------------------
echo "Welcome Mr./Mrs. ${first_name}, would you like to tell us your last name?"
read -r last_name

#------------------------------------------------------------------------------
# Display greeting message
#------------------------------------------------------------------------------
echo "Thanks Mr./Mrs. ${first_name} ${last_name} for telling us your name"

#------------------------------------------------------------------------------
# Visual separator
#------------------------------------------------------------------------------
echo "***********************************************************************"

#------------------------------------------------------------------------------
# Farewell message
#------------------------------------------------------------------------------
echo "Mr./Mrs. ${last_name}, it's time to say goodbye"
