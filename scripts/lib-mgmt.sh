# scripts/manage_libs.sh
#!/bin/bash

# Source common functions and variables
source "$(dirname "$0")/common.sh"

BUNDLE_VERSION="8.x" # Change this to match your CircuitPython version
BUNDLE_NAME="adafruit-circuitpython-bundle-${BUNDLE_VERSION}-mpy"
BUNDLE_URL="https://github.com/adafruit/Adafruit_CircuitPython_Bundle/releases/download/\
${BUNDLE_VERSION}/${BUNDLE_NAME}.zip"
TEMP_DIR="/tmp/circuit_libs"

# Function to download and extract bundle
download_bundle() {
    print_info "Downloading CircuitPython library bundle..."
    mkdir -p "$TEMP_DIR"
    curl -L "$BUNDLE_URL" -o "$TEMP_DIR/bundle.zip"
    unzip -q -o "$TEMP_DIR/bundle.zip" -d "$TEMP_DIR"
}

# Function to install specific library
install_lib() {
    local lib_name=$1
    local bundle_lib_dir="$TEMP_DIR/${BUNDLE_NAME}/lib"
    local project_lib_dir="$SRC_PATH/lib"

    print_info "Installing $lib_name..."

    # Create lib directory if it doesn't exist
    mkdir -p "$project_lib_dir"

    # Check if library exists in bundle
    if [ -d "$bundle_lib_dir/$lib_name" ]; then
        cp -r "$bundle_lib_dir/$lib_name" "$project_lib_dir/"
        print_success "Installed $lib_name directory"
    elif [ -f "$bundle_lib_dir/${lib_name}.mpy" ]; then
        cp "$bundle_lib_dir/${lib_name}.mpy" "$project_lib_dir/"
        print_success "Installed ${lib_name}.mpy"
    else
        print_error "Library $lib_name not found in bundle"
        return 1
    fi
}

# Function to install all requirements
install_requirements() {
    if [ ! -f "lib-requirements.txt" ]; then
        print_error "lib-requirements.txt not found"
        exit 1
    fi

    download_bundle

    while IFS= read -r lib || [ -n "$lib" ]; do
        # Skip comments and empty lines
        [[ $lib =~ ^#.*$ ]] || [ -z "$lib" ] && continue
        install_lib "$lib"
    done < "lib-requirements.txt"

    # Cleanup
    rm -rf "$TEMP_DIR"
    print_success "All libraries installed successfully!"
}

# Main
case "$1" in
    "install")
        install_requirements
        ;;
    "clean")
        rm -rf "$SRC_PATH/lib"
        print_success "Cleaned lib directory"
        ;;
    *)
        echo "Usage: $0 {install|clean}"
        exit 1
        ;;
esac
