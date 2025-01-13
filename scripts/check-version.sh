#!/bin/bash

# Source common functions and variables
source "$(dirname "$0")/common.sh"

# Function to get CircuitPython version from boot_out.txt
get_circuitpy_version() {
    if [ -f "$CIRCUIT_PATH/boot_out.txt" ]; then
        local version=$(cat "$CIRCUIT_PATH/boot_out.txt" | grep "Adafruit CircuitPython" | sed -E 's/.*([0-9]+\.[0-9]+\.[0-9]+).*/\1/')
        if [ ! -z "$version" ]; then
            echo "$version"
            return 0
        fi
    fi
    return 1
}

# Function to check CircuitPython version
check_version() {
    check_mounted

    print_info "Checking CircuitPython version..."
    local version=$(get_circuitpy_version)

    if [ $? -eq 0 ]; then
        print_success "CircuitPython Version: $version"
        # Store version for other scripts to use
        echo "$version" > .circuitpython-version
    else
        print_error "Could not determine CircuitPython version"
        exit 1
    fi
}

# Run version check
check_version
