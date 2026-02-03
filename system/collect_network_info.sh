#!/usr/bin/env bash
###############################################################################
# Script Name  : network_diagnostics.sh
# Description  : Collects comprehensive network and system configuration
#                information and logs it to a timestamped output file.
#
# Author       : Suman Kafle
# Created Date : 2026-02-02
#
# Usage        :
#   sudo chmod +x network_diagnostics.sh
#   sudo ./network_diagnostics.sh
#
# Output       :
#   network.<DD-MM-YY>.info.txt
#
# Exit Codes   :
#   0   Success
#   999 Must be run as root
#
# Notes        :
#   - Script must be executed as root
#   - Designed for RedHat/CentOS-style networking layouts
#   - Intended for troubleshooting and diagnostics
###############################################################################

#------------------------------------------------------------------------------
# Command paths (explicit paths for reliability)
#------------------------------------------------------------------------------
IP4FW="/sbin/iptables"
IP6FW="/sbin/ip6tables"
LSPCI="/usr/bin/lspci"
ROUTE="/sbin/route"
NETSTAT="/bin/netstat"
LSB="/usr/bin/lsb_release"

#------------------------------------------------------------------------------
# Configuration files
#------------------------------------------------------------------------------
DNSCLIENT="/etc/resolv.conf"
DRVCONF="/etc/modprobe.conf"
NETCFC="/etc/sysconfig/network-scripts/ifcfg-eth?"
NETALIASCFC="/etc/sysconfig/network-scripts/ifcfg-eth?-range?"
NETSTATICROUTECFC="/etc/sysconfig/network-scripts/route-eth?"
SYSCTL="/etc/sysctl.conf"

#------------------------------------------------------------------------------
# Output file
#------------------------------------------------------------------------------
OUTPUT="network.$(date +'%d-%m-%y').info.txt"

#------------------------------------------------------------------------------
# Function: chk_root
# Purpose : Ensure the script is executed with root privileges
#------------------------------------------------------------------------------
chk_root() {
    if [[ "$(id -u)" -ne 0 ]]; then
        echo "Error: This script must be run as root." >&2
        exit 999
    fi
}

#------------------------------------------------------------------------------
# Function: write_header
# Purpose : Write a formatted section header to the output file
#------------------------------------------------------------------------------
write_header() {
    {
        echo "---------------------------------------------------"
        echo "$*"
        echo "---------------------------------------------------"
    } >> "${OUTPUT}"
}

#------------------------------------------------------------------------------
# Function: dump_info
# Purpose : Collect and log network/system diagnostics
#------------------------------------------------------------------------------
dump_info() {

    #--------------------------------------------------------------------------
    # Basic system information
    #--------------------------------------------------------------------------
    {
        echo "* Hostname          : $(hostname)"
        echo "* Run date & time   : $(date)"
    } > "${OUTPUT}"

    write_header "Linux Distribution Information"
    echo "Linux Kernel: $(uname -mrs)" >> "${OUTPUT}"
    "${LSB}" -a >> "${OUTPUT}"

    write_header "PCI Devices"
    "${LSPCI}" -v >> "${OUTPUT}"

    write_header "Kernel Routing Table"
    "${ROUTE}" -n >> "${OUTPUT}"

    write_header "Network Driver Configuration (${DRVCONF})"
    [[ -f "${DRVCONF}" ]] && grep eth "${DRVCONF}" >> "${OUTPUT}" \
        || echo "Error: ${DRVCONF} not found." >> "${OUTPUT}"

    write_header "DNS Client Configuration (${DNSCLIENT})"
    [[ -f "${DNSCLIENT}" ]] && cat "${DNSCLIENT}" >> "${OUTPUT}" \
        || echo "Error: ${DNSCLIENT} not found." >> "${OUTPUT}"

    write_header "Network Interface Configuration Files"
    for f in ${NETCFC}; do
        [[ -f "${f}" ]] && { echo "** ${f} **"; cat "${f}"; } >> "${OUTPUT}" \
            || echo "Error: ${f} not found." >> "${OUTPUT}"
    done

    write_header "Network Alias Configuration Files"
    for f in ${NETALIASCFC}; do
        [[ -f "${f}" ]] && { echo "** ${f} **"; cat "${f}"; } >> "${OUTPUT}" \
            || echo "Error: ${f} not found." >> "${OUTPUT}"
    done

    write_header "Static Route Configuration Files"
    for f in ${NETSTATICROUTECFC}; do
        [[ -f "${f}" ]] && { echo "** ${f} **"; cat "${f}"; } >> "${OUTPUT}" \
            || echo "Error: ${f} not found." >> "${OUTPUT}"
    done

    write_header "IPv4 Firewall Rules"
    "${IP4FW}" -L -n >> "${OUTPUT}"

    write_header "IPv6 Firewall Rules"
    "${IP6FW}" -L -n >> "${OUTPUT}"

    write_header "Network Statistics"
    "${NETSTAT}" -s >> "${OUTPUT}"

    write_header "Kernel Network Tuning (${SYSCTL})"
    [[ -f "${SYSCTL}" ]] && cat "${SYSCTL}" >> "${OUTPUT}" \
        || echo "Error: ${SYSCTL} not found." >> "${OUTPUT}"

    echo "Diagnostics written to: ${OUTPUT}"
}

#------------------------------------------------------------------------------
# Script entry point
#------------------------------------------------------------------------------
chk_root
dump_info
