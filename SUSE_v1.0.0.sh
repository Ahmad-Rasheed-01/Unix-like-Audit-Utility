#!/bin/bash


########################################################################################
#                             USER GUIDE                                               #
#--------------------------------------------------------------------------------------#
# Version: 1.0.0                                                                       #
# Author: Ahmad Rasheed                                                                #
# This script collects system information and compresses it to a timestamped           #
# tar.gz file.                                                                         #
#                                                                                      #
# Prerequisites:                                                                       #
# a) The script must be run as root (sudo).                                            #
# b) Make the script executable by running:                                            #
#      chmod +x SUSE_v1.0.0.sh                                                         #
# c) Execute the script using:                                                         #
#      sudo ./SUSE_v1.0.0.sh                                                           #
# d) The script automatically creates a tar.gz file in the current directory.          #
# e) Share the generated tar.gz file as needed.                                        #
#                                                                                      # 
#                                                                                      #
#--------------------------------------------------------------------------------------#
#                       Operational Instructions                                       #
#--------------------------------------------------------------------------------------#
# a) Scrutinize the contents of the script to ensure that it does not contain          #
#    any statements, commands or any other code that might negatively influence        #
#    the environment(s) in either a security or operational way.                       #
# b) Test the script on the test environment to ensure that it does not contain        #
#    any statements, commands or any other code that might negatively influence        #
#    the environment(s) in either a security or operational way.                       #
# c) The final responsibility for executing this script lies with the executor.        #
# d) It is advised to execute the script during off-peak hours.                        #
#                                                                                      #
# Notes:                                                                               #
# - This script is designed for SUSE Linux systems.                                    #
# - Ensure you have sufficient permissions to read system files.                       #
# - Some commands/files may not be available depending on the OS version.              #
# - This script is READ-ONLY and does not modify any system states or configurations.  #
# - For updates, visit: https://github.com/Ahmad-Rasheed-01/Unix-like-Audit-Program    #
#                                                                                      #
########################################################################################


# color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[1;34m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# Display banner
echo -e "${BLUE}"
echo -e "══════════════════════════════════════════════════════════════════════════════════════════════════════════════"
echo -e "                                                                                                            "
echo -e "        ${WHITE}███████╗██╗   ██╗███████╗███████╗     █████╗ ██╗   ██╗██████╗ ██╗████████╗${BLUE}       "
echo -e "        ${WHITE}██╔════╝██║   ██║██╔════╝██╔════╝    ██╔══██╗██║   ██║██╔══██╗██║╚══██╔══╝${BLUE}       "
echo -e "        ${WHITE}███████╗██║   ██║███████╗█████╗      ███████║██║   ██║██║  ██║██║   ██║${BLUE}          "
echo -e "        ${WHITE}╚════██║██║   ██║╚════██║██╔══╝      ██╔══██║██║   ██║██║  ██║██║   ██║${BLUE}          "
echo -e "        ${WHITE}███████║╚██████╔╝███████║███████╗    ██║  ██║╚██████╔╝██████╔╝██║   ██║${BLUE}          "
echo -e "        ${WHITE}╚══════╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝   ╚═╝${BLUE}          "
echo -e "                                                                                                            "
echo -e "                                 ${YELLOW}🔒 A Security Audit Utility 🔒${BLUE}                                  "
echo -e "                                ${GREEN}Developed under Unix-Like Audit Program${BLUE}                             "
echo -e "                                                                                                            "
echo -e "                                                                                                            "
echo -e "    ${WHITE}Platform: SUSE Linux${BLUE}                                                                             "
echo -e "    ${WHITE}Version: 1.0.0${BLUE}                                                                                 "
echo -e "    ${WHITE}For Updates Please Visit: https://github.com/Ahmad-Rasheed-01/Unix-Like-Audit-Program${BLUE}          "
echo -e "                                                                                                            "
echo -e "══════════════════════════════════════════════════════════════════════════════════════════════════════════════"
echo -e "${NC}"
echo

# Function to check OS compatibility
check_os_compatibility() {
    local detected_os="Unknown"
    local script_type="SUSE Linux"
    local repo_url="https://github.com/Ahmad-Rasheed-01/Unix-Like-Audit-Program"
    
    echo -e "${CYAN}Checking OS compatibility...${NC}"
    
    # Detect operating system
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            "sles"|"opensuse"|"opensuse-leap"|"opensuse-tumbleweed")
                detected_os="SUSE Linux"
                if grep -qi "suse linux enterprise" /etc/os-release 2>/dev/null; then
                    echo -e "${GREEN}✓ OS Detection: SUSE Linux Enterprise detected${NC}"
                elif grep -qi "opensuse" /etc/os-release 2>/dev/null; then
                    echo -e "${GREEN}✓ OS Detection: openSUSE detected${NC}"
                else
                    echo -e "${GREEN}✓ OS Detection: SUSE-based system detected${NC}"
                fi
                echo -e "${GREEN}✓ Script Compatibility: This script is optimized for your system${NC}"
                echo
                read -p "Do you want to continue with the collection? (Y/n): " REPLY
                if [[ $REPLY =~ ^[Nn]$ ]]; then
                    echo -e "${RED}Collection cancelled by user.${NC}"
                    exit 0
                fi
                echo -e "${CYAN}Continuing with $script_type collection...${NC}"
                echo
                return 0
                ;;
            "rhel"|"centos"|"fedora"|"rocky"|"almalinux")
                detected_os="RedHat/RHEL Compatible"
                ;;
            "oracle")
                detected_os="Oracle Linux"
                ;;
            "ubuntu"|"debian")
                detected_os="Debian/Ubuntu"
                ;;
            "aix")
                detected_os="AIX"
                ;;
            *)
                detected_os="$NAME ($ID)"
                ;;
        esac
    elif [ -f /etc/SuSE-release ] || [ -f /etc/SUSE-brand ]; then
        detected_os="SUSE Linux"
        echo -e "${GREEN}✓ OS Detection: SUSE Linux detected${NC}"
        echo -e "${GREEN}✓ Script Compatibility: This script is optimized for your system${NC}"
        echo
        read -p "Do you want to continue with the collection? (Y/n): " REPLY
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            echo -e "${RED}Collection cancelled by user.${NC}"
            exit 0
        fi
        echo -e "${CYAN}Continuing with $script_type collection...${NC}"
        echo
        return 0
    elif [ -f /etc/redhat-release ]; then
        detected_os="RedHat/RHEL Compatible"
    elif [ -f /etc/oracle-release ]; then
        detected_os="Oracle Linux"
    elif [ -f /etc/debian_version ]; then
        detected_os="Debian/Ubuntu"
    elif uname -s | grep -qi "aix"; then
        detected_os="AIX"
    fi
    
    # If we reach here, the OS is not compatible
    echo -e "${RED}✗ OS Detection: $detected_os detected${NC}"
    echo -e "${RED}✗ Script Compatibility: This script is designed for $script_type systems${NC}"
    echo -e "${YELLOW}Please use the appropriate script for your operating system:${NC}"
    echo -e "${WHITE}  • For RedHat/RHEL: RedHat_v1.0.0.sh${NC}"
    echo -e "${WHITE}  • For Oracle Linux: Oracle_v1.0.0.sh${NC}"
    echo -e "${WHITE}  • For AIX: AIX_v1.0.0.sh${NC}"
    echo -e "${WHITE}  • For Debian/Ubuntu: Debian-based_v1.0.0.sh${NC}"
    echo
    echo -e "${CYAN}For the correct version, please visit:${NC}"
    echo -e "${BLUE}$repo_url${NC}"
    echo
    read -p "Do you want to continue anyway? (y/N): " REPLY
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Exiting script. Please use the appropriate audit script for your system.${NC}"
        exit 1
    fi
    echo -e "${YELLOW}⚠ Warning: Continuing with $script_type audit on an incompatible system.${NC}"
    echo -e "${YELLOW}⚠ Some features may not work correctly.${NC}"
}

# Check OS compatibility
check_os_compatibility

# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}This script must be run as root.${NC}"
    exit 1
fi

# Getting hostname, IP address, and current date-time
echo ; echo "Obtaining system hostname, IP address, and current date-time"
hostname=$(hostname)
ip_address=$(hostname -I | awk '{print $1}')
datetime=$(date +"%Y%m%d_%H%M%S")
echo

# Create the folder name and directory
folder_name="SUSE_${hostname}[${ip_address}]${datetime}"
echo "Creating folder: $folder_name"
mkdir -p "$folder_name"
echo "DONE." ; echo

# Copy the specified files to the folder
echo "Copying system configuration files..."
cp /etc/passwd /etc/group /etc/login.defs /etc/sudoers /etc/shadow /etc/hosts /etc/resolv.conf /etc/os-release /etc/SuSE-release "$folder_name" 2>/dev/null
#cp /etc/pam.d/system-auth /etc/pam.d/password-auth /etc/security/pwquality.conf "$folder_name" 2>/dev/null
cp /etc/pam.d/common-auth /etc/pam.d/common-password "$folder_name" 2>/dev/null
cp /etc/audit/auditd.conf /etc/audit/rules.d/audit.rules "$folder_name" 2>/dev/null
#cp -r /etc/cron.d*
echo "DONE." ; echo

# Get password change details of all users
echo "Collecting password change status for all users..."
for user in $(cut -d: -f1 /etc/passwd); do passwd -S "$user"; done > "$folder_name/password_change.txt"
echo "DONE." ; echo

# Collect log file hierarchy
echo "Collecting log file hierarchy from /var/log..."
ls -lR /var/log > "$folder_name/file_hierarchy.txt"
echo "DONE." ; echo

echo "Collecting login information..."
#lslogins > "$folder_name/logins.txt"
getent passwd > "$folder_name/logins.txt"
w > "$folder_name/who.txt"
#timedatectl status | grep "NTP synchronized" > "$folder_name/ntp_sync_status.txt"
# crontab -l > "$folder_name/cronjobs.txt" 2>/dev/null || echo "No crontab found" > "$folder_name/cronjobs.txt"
echo "DONE." ; echo

echo "Collecting ping results..."
ping -c 4 "$(hostname)" > "$folder_name/ping_hostname.txt"
ping -c 4 8.8.8.8 > "$folder_name/ping_google.txt"
echo "DONE." ; echo

echo "Collecting applied patches detail..."
#rpm -qai > "$folder_name/patches.txt" 2>/dev/null || echo "RPM not available on this system" > "$folder_name/patches.txt"
zypper info --installed-only > "$folder_name/patches.txt"
echo "DONE." ; echo

echo "Collecting network port details..."
#netstat -tuln > "$folder_name/network_ports.txt" 2>/dev/null || ss -tuln > "$folder_name/network_ports.txt"
ss -tuln > "$folder_name/network_ports.txt"
echo "DONE." ; echo

# Collect running processes and services
echo "Collecting running processes and service status..."
systemctl list-units --type=service --all > "$folder_name/services_status.txt"
ps -ef > "$folder_name/processes.txt"
echo "DONE." ; echo

# Check NTP sync status
echo "Collecting NTP sync details..."
if command -v chronyc &> /dev/null; then
    chronyc tracking > "$folder_name/ntp_sync_status.txt"
elif command -v ntpq &> /dev/null; then
    ntpq -p > "$folder_name/ntp_sync_status.txt"
else
    echo "NTP sync status check failed: Neither chronyc nor ntpq is available." > "$folder_name/ntp_sync_status.txt"
fi
echo "DONE." ; echo

# Check cron jobs
echo "Collecting cron jobs information..."
{
    echo "System-wide cron jobs (/etc/crontab):"
    echo "------------------------------------"
    if [ -f /etc/crontab ]; then
        cat /etc/crontab
    else
        echo "No /etc/crontab file found."
    fi

    echo -e "\nCron jobs in /etc/cron.* directories:"
    echo "-------------------------------------"
    for cron_dir in /etc/cron.*; do
        if [ -d "$cron_dir" ]; then
            echo -e "\nDirectory: $cron_dir"
            for file in "$cron_dir"/*; do
                if [ -f "$file" ]; then
                    echo -e "\nFile: $file"
                    cat "$file"
                fi
            done
        fi
    done

    echo -e "\nUser-specific cron jobs:"
    echo "-------------------------"
    for user in $(cut -d: -f1 /etc/passwd); do
        echo -e "\nCron jobs for user: $user"
        crontab -u "$user" -l 2>/dev/null || echo "No crontab for $user"
    done
} > "$folder_name/cron_jobs.txt"
echo "DONE." ; echo

# Collect user home directory information
echo "Collecting user home directory information..."
{
    echo "User Home Directory Information"
    echo "==============================="
    echo
    
    first_user=true
    while IFS=: read -r username password uid gid gecos home_dir shell; do
        # Add separator before each user (except the first one)
        if [ "$first_user" = true ]; then
            first_user=false
        else
            echo "----------------------------------------"
            echo
        fi
        
        echo "User: $username (UID: $uid, GID: $gid)"
        echo "Home Directory: $home_dir"
        echo "Shell: $shell"
        
        if [ -d "$home_dir" ]; then
            echo "Directory exists: Yes"
            
            # Get stat information with timeout
            echo "Stat information:"
            timeout 10 stat "$home_dir" 2>/dev/null || echo "[Timeout or access denied]"
        else
            echo "Directory exists: No"
        fi
        
        echo
    done < /etc/passwd
} > "$folder_name/user_home_dir.txt"
echo "DONE." ; echo

# Create tar file
tar_file="${folder_name}.tar.gz"
echo "Creating tar file: $tar_file"
tar -czvf "$tar_file" "$folder_name" >/dev/null
echo "DONE." ; echo

echo -e "${GREEN}Script execution completed. All files and outputs are saved in ${NC}${BLUE}$tar_file${NC}${GREEN}.${NC}"
echo -e "${CYAN}The tar file (${tar_file}) is ready to be copied to secure storage.${NC}"
