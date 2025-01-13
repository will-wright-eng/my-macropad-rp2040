#!/bin/bash

# Source common functions and variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_DIR}/common.sh"

# Main clean script
main() {
    check_mounted
    check_writable

    # Create backup before cleaning
    print_info "Creating backup before cleaning..."
    ./backup.sh

    # Remove all files except lib directory and boot_out.txt
    print_info "Cleaning CIRCUITPY drive..."
    find "$CIRCUIT_PATH" -mindepth 1 -maxdepth 1 \
        ! -name 'lib' \
        ! -name 'boot_out.txt' \
        -exec rm -rf {} +

    print_success "Clean completed!"
}

# Run main function
main
