#!/bin/bash

sudo apt update
sudo apt install sqlite3 -y

# Path to the SQLite database file
DB_FILE="../../obsidian-vault/everything.db"

CRITERIA="plat_linux=1 AND pkg_linux IS NOT NULL AND pkg_linux != ''"
QUERY="SELECT pkg_linux FROM inventory_software WHERE $CRITERIA;"

# Run the SQLite query using the sqlite3 command and store the result in an array
result_array=($(sqlite3 "$DB_FILE" "$QUERY"))

install_string=""

# Print the elements of the array
for element in "${result_array[@]}"; do
  install_string="$install_string $element"
done

# Install the packages
sudo apt install $install_string -y