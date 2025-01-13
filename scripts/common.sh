#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Common paths (updated to use absolute paths)
CIRCUIT_PATH="/Volumes/CIRCUITPY"
SRC_PATH="${SCRIPT_DIR}/../src"
BACKUP_PATH="${SCRIPT_DIR}/../archive"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if CIRCUITPY is mounted
check_mounted() {
    if [ ! -d "$CIRCUIT_PATH" ]; then
        echo -e "${RED}Error: CIRCUITPY drive not found at $CIRCUIT_PATH${NC}"
        echo "Please make sure your MacroPad is connected and mounted."
        exit 1
    fi
}

# Function to check if drive is writable
check_writable() {
    if [ ! -w "$CIRCUIT_PATH" ]; then
        echo -e "${RED}Error: CIRCUITPY drive is not writable${NC}"
        echo "Please check if the drive is write-protected."
        exit 1
    fi
}

# Function to print success message
print_success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to print error message
print_error() {
    echo -e "${RED}$1${NC}"
}

# Function to print warning/info message
print_info() {
    echo -e "${YELLOW}$1${NC}"
}
