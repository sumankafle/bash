#!/usr/bin/env bash
###############################################################################
# Script Name  : cpu_usage_alert.sh
# Description  : Monitors CPU usage and sends an email alert if the usage
#                exceeds a defined threshold.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x cpu_usage_alert.sh
#   ./cpu_usage_alert.sh
#
# Exit Codes   :
#   0  Success
#   1  Alert triggered (CPU usage exceeded threshold)
#
# Notes        :
#   - Reads CPU statistics from /proc/stat
#   - Uses awk for floating-point arithmetic
#   - Requires a configured mail system (mailx / sendmail)
###############################################################################

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------
#ALERT_EMAIL="server@127.0.0.1"

#------------------------------------------------------------------------------
# Calculate CPU usage percentage
#------------------------------------------------------------------------------
CPU_USAGE=$(
    awk '/^cpu / {
        usage = ($2 + $4) * 100 / ($2 + $4 + $5);
        printf "%.0f\n", usage
    }' /proc/stat
)

#------------------------------------------------------------------------------
# Check CPU usage against threshold
#------------------------------------------------------------------------------
echo "Percent used: ${CPU_USAGE}%" 
