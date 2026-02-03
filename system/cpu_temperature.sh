#!/usr/bin/env bash
###############################################################################
# Script Name  : cpu_temperature.sh
# Description  : Reads CPU temperature from the Linux thermal subsystem and
#                displays the temperature in Celsius.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x cpu_temperature.sh
#   ./cpu_temperature.sh
#
# Exit Codes   :
#   0  Success
#   1  Temperature source not found
#
# Notes        :
#   - Reads temperature from /sys/class/thermal
#   - Assumes temperature is reported in millidegrees Celsius
#   - Compatible with most Linux systems (including Ubuntu)
###############################################################################

#------------------------------------------------------------------------------
# Temperature source file
#------------------------------------------------------------------------------
TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"

#------------------------------------------------------------------------------
# Validate temperature file existence
#------------------------------------------------------------------------------
if [[ ! -r "${TEMP_FILE}" ]]; then
    echo "Error: Temperature file not found: ${TEMP_FILE}" >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Read and convert temperature
#------------------------------------------------------------------------------
ORIGINAL_TEMP="$(cat "${TEMP_FILE}")"     # Temperature in millidegrees Celsius
TEMP_C=$(( ORIGINAL_TEMP / 1000 ))         # Convert to degrees Celsius
#TEMP_F=$(( TEMP_C * 9 / 5 + 32 ))           # Convert to degrees Fahrenheit

#------------------------------------------------------------------------------
# Output temperature
#------------------------------------------------------------------------------
echo "${TEMP_C} °C"
