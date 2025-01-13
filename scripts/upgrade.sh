#!/bin/bash

# Source common functions and variables
source "$(dirname "$0")/common.sh"

BOOTLOADER_PATH="/Volumes/RPI-RP2"
DOWNLOAD_DIR="/tmp/circuitpython"
BOARD_URL="https://downloads.circuitpython.org/bin/adafruit_macropad_rp2040/en_US"

# Function to download latest UF2
download_latest() {
    print_info "Downloading latest CircuitPython..."
    mkdir -p "$DOWNLOAD_DIR"

    # Get latest version from website
    LATEST_VERSION=$(curl -s https://circuitpython.org/board/adafruit_macropad_rp2040/ | \
        grep -o 'https://downloads.circuitpython.org/bin/adafruit_macropad_rp2040/en_US/adafruit[-]circuitpython[-].*[.]uf2' | \
        head -n 1)

    if [ -z "$LATEST_VERSION" ]; then
        print_error "Could not determine latest version"
        exit 1
    fi

    # Download UF2 file
    curl -L "$LATEST_VERSION" -o "$DOWNLOAD_DIR/circuitpython.uf2"

    if [ $? -eq 0 ]; then
        print_success "Downloaded latest CircuitPython UF2"
    else
        print_error "Failed to download UF2 file"
        exit 1
    fi
}

# Function to wait for bootloader
wait_for_bootloader() {
    print_info "Waiting for bootloader mode..."
    print_info "Please double-click the reset button on your MacroPad"
    print_info "if this doesn't work, hold down the boot button (by pressing the rotary encoder!), and while continuing to hold it (don't let go!), press and release the reset button. Continue to hold the boot button until the RPI-RP2 drive appears!"
    print_info "https://learn.adafruit.com/adafruit-macropad-rp2040/arduino-usage#manually-enter-the-bootloader-3107275"

    local timeout=30
    local counter=0

    while [ ! -d "$BOOTLOADER_PATH" ] && [ $counter -lt $timeout ]; do
        sleep 1
        counter=$((counter + 1))
        echo -n "."
    done
    echo ""

    if [ ! -d "$BOOTLOADER_PATH" ]; then
        print_error "Bootloader not found. Is the device in bootloader mode?"
        exit 1
    fi

    print_success "Bootloader detected!"
}

# Function to flash UF2
flash_uf2() {
    print_info "Flashing CircuitPython..."

    cp "$DOWNLOAD_DIR/circuitpython.uf2" "$BOOTLOADER_PATH/"

    if [ $? -eq 0 ]; then
        print_success "Flash successful!"
    else
        print_error "Failed to flash UF2 file"
        exit 1
    fi
}

# Function to verify upgrade
verify_upgrade() {
    print_info "Waiting for device to restart..."
    sleep 5

    # Check new version
    ./scripts/check_version.sh
}

# Main upgrade process
main() {
    # Create backup first
    print_info "Creating backup before upgrade..."
    ./scripts/backup.sh

    # Download latest version
    download_latest

    # Wait for bootloader
    wait_for_bootloader

    # Flash new version
    flash_uf2

    # Verify upgrade
    verify_upgrade

    # Cleanup
    rm -rf "$DOWNLOAD_DIR"

    print_success "Upgrade completed successfully!"
}

# Run main function
main
