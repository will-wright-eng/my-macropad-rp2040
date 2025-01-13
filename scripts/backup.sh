#!/bin/bash

# Source common functions and variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_DIR}/common.sh"

# Function to create backup
create_backup() {
    print_info "Creating backup of current CIRCUITPY contents..."
    mkdir -p "$BACKUP_PATH"
    BACKUP_DIR="$BACKUP_PATH/backup_$(date +%Y%m%d_%H%M%S)"

    # Copy current contents to backup
    cp -R "$CIRCUIT_PATH/" "$BACKUP_DIR"
    if [ $? -eq 0 ]; then
        print_success "Backup created at $BACKUP_DIR"
        return 0
    else
        print_error "Failed to create backup"
        exit 1
    fi
}

# Main backup script
main() {
    check_mounted
    create_backup
}

# Run main function
main
