#!/usr/bin/env bash
###############################################################################
# Script Name  : disk_usage_alert.sh
# Description  : Monitors disk usage for a specific partition and sends an
#                email alert if usage exceeds a defined threshold.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   chmod +x disk_usage_alert.sh
#   ./disk_usage_alert.sh
#
# Exit Codes   :
#   0  Success
#   1  Alert triggered (disk usage exceeded threshold)
#
# Notes        :
#   - Uses `df -h` to check disk utilization
#   - Requires a working mail setup (mailx / sendmail)
#   - Intended for cron or server monitoring
###############################################################################

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------
MAX_DISK_THRESHOLD=95          # Percentage threshold for disk usage
PARTITION="sda1"               # Disk partition identifier

#------------------------------------------------------------------------------
# Retrieve disk usage percentage for the specified partition
#------------------------------------------------------------------------------
DISK_USAGE=$(
    df -h \
    | awk -v part="${PARTITION}" '$0 ~ part { gsub(/%/, "", $5); print $5 }'
)

#------------------------------------------------------------------------------
# Validate retrieved disk usage
#------------------------------------------------------------------------------
if [[ -z "${DISK_USAGE}" ]]; then
    echo "Error: Partition '${PARTITION}' not found." >&2
    exit 1
fi

#------------------------------------------------------------------------------
# Check disk usage against threshold
#------------------------------------------------------------------------------
if (( DISK_USAGE > MAX_DISK_THRESHOLD )); then
    echo "Percent used: ${DISK_USAGE}%" 
    exit 1
fi
