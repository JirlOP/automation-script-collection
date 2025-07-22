#!/bin/bash

# File containing the list of specific package versions to install.
PACKAGE_FILE="packages_to_install.txt"

# Verify the script is run as root (sudo).
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo."
  exit 1
fi

# Verify the package file exists.
if [ ! -f "$PACKAGE_FILE" ]; then
  echo "Error: Could not find '$PACKAGE_FILE' in the current directory."
  exit 1
fi

# Read packages from the file into a space-separated list.
packages=$(cat "$PACKAGE_FILE" | tr '\n' ' ')

# Check if the package list is empty.
if [ -z "$packages" ]; then
  echo "The file '$PACKAGE_FILE' is empty. Nothing to do."
  exit 0
fi

echo "🚀 Starting installation of the following specific package versions:"
echo "$packages"
echo "------------------------------------------------------------"

# Execute the DNF install command with the '-y' flag to auto-confirm.
dnf install $packages -y

echo "------------------------------------------------------------"
echo "✅ Patching process completed."
echo "⚠️  A system reboot is required for kernel updates to take effect."
