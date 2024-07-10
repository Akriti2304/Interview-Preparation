#!/bin/bash

# Check if all required arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <REMOTE_HOST> <SSH_USER> <SSH_KEY>"
    exit 1
fi

REMOTE_HOST="$1"
SSH_USER="$2"
SSH_KEY="$3"

# Function to execute commands remotely via SSH
run_remote_command() {
    ssh -i "$SSH_KEY" "$SSH_USER@$REMOTE_HOST" "$1"
}

# Function to fetch and display hostname
fetch_hostname() {
    echo "Hostname:"
    run_remote_command "uname -n"
    echo
}

# Function to fetch network interfaces details
fetch_network_interfaces() {
    echo "Network Interfaces - MAC addresses, IP addresses, and subnets:"
    run_remote_command "ifconfig -a"
    echo
}

# Function to fetch operating system details
fetch_os_details() {
    echo "Operating System, Kernel version, and Distribution:"
    run_remote_command "uname -a; lsb_release -a"
    echo
}

# Function to list installed software/packages
fetch_installed_software() {
    echo "List of Installed Software:"
    run_remote_command "dpkg -l || rpm -qa"
    echo
}

# Function to fetch users and admin users
fetch_users() {
    echo "Users and Admin Users:"
    run_remote_command "cat /etc/passwd"
    echo
}

# Function to fetch hard drives and file systems
fetch_disk_filesystems() {
    echo "Hard Drives and File Systems:"
    run_remote_command "df -h"
    echo
}

# Function to fetch CPUs and RAM
fetch_cpus_ram() {
    echo "CPUs and RAM:"
    run_remote_command "lscpu; free -h"
    echo
}

# Function to fetch running services
fetch_services() {
    echo "Running Services:"
    run_remote_command "systemctl list-units --type=service --state=running"
    echo
}

# Function to fetch listening ports
fetch_listening_ports() {
    echo "Listening Ports:"
    run_remote_command "netstat -tuln"
    echo
}

# Function to fetch hardware details including serials
fetch_hardware_details() {
    echo "Hardware Details (including serials):"
    run_remote_command "dmidecode"
    echo
}

# Main function to call all fetch functions
main() {
    fetch_hostname
    fetch_network_interfaces
    fetch_os_details
    fetch_installed_software
    fetch_users
    fetch_disk_filesystems
    fetch_cpus_ram
    fetch_services
    fetch_listening_ports
    fetch_hardware_details
}

# Call the main function to execute the script
main
