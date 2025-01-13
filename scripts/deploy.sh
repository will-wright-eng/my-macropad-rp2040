#!/bin/bash

# Source common functions and variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_DIR}/common.sh"

# Function to sync files
sync_files() {
    print_info "Deploying files to CIRCUITPY..."

    # Create lib directory if it doesn't exist
    mkdir -p "$CIRCUIT_PATH/lib"

    # First, copy everything except lib directory
    rsync -av --exclude 'lib' "$SRC_PATH/" "$CIRCUIT_PATH/"

    # Then, only copy new or modified files from lib
    if [ -d "$SRC_PATH/lib" ]; then
        rsync -av --update "$SRC_PATH/lib/" "$CIRCUIT_PATH/lib/"
    fi

    # Force sync to ensure all files are written
    sync

    if [ $? -eq 0 ]; then
        print_success "Deployment successful!"
        return 0
    else
        print_error "Deployment failed"
        exit 1
    fi
}

# Main deployment script
main() {
    print_info "Starting deployment to MacroPad..."

    # Run checks
    check_mounted
    check_writable

    # Create backup
    ./backup.sh

    # Deploy files
    sync_files

    print_success "Deployment completed successfully!"
}

# Run main function
main
