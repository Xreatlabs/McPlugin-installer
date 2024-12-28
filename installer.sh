#!/bin/bash

clear
# Ensure required tools are installed
if ! command -v curl &> /dev/null; then
  echo "curl is required but not installed. Installing..."
  sudo apt update && sudo apt install -y curl
fi

if ! command -v jq &> /dev/null; then
  echo "jq is required but not installed. Installing..."
  sudo apt update && sudo apt install -y jq
fi

# Directories for downloaded resources
RESOURCE_DIR="resources"
mkdir -p "$RESOURCE_DIR"

# Function to clear the terminal and display the header
clear_screen() {
  clear
  echo "============================="
  echo "Advanced Minecraft Installer"
  echo "============================="
}

# Function to install from SpigotMC (Spiget API)
install_from_spigot() {
  local resource_name=$1
  echo "Searching for \"$resource_name\" on SpigotMC..."
  local plugin_data=$(curl -s "https://api.spiget.org/v2/search/resources/$resource_name" | jq '.[0]')

  if [ "$(echo "$plugin_data" | jq -r '.id')" != "null" ]; then
    local plugin_id=$(echo "$plugin_data" | jq -r '.id')
    local plugin_name=$(echo "$plugin_data" | jq -r '.name')
    echo "Found plugin: $plugin_name (ID: $plugin_id)"
    echo "Downloading \"$plugin_name\" from SpigotMC..."
    curl -L "https://api.spiget.org/v2/resources/$plugin_id/download" -o "$RESOURCE_DIR/$plugin_name.jar"
    echo "✅ Plugin \"$plugin_name\" downloaded to $RESOURCE_DIR/$plugin_name.jar"
    return 0
  else
    echo "❌ No plugin found on SpigotMC for \"$resource_name\"."
    return 1
  fi
}

# Function to install from Hangar
install_from_hangar() {
  local resource_name=$1
  echo "Searching for \"$resource_name\" on Hangar..."
  read -p "Enter the Hangar namespace (e.g., papermc/paper): " namespace
  local latest_version=$(curl -s "https://hangar.papermc.io/api/v1/projects/$namespace/versions" | jq -r '.[0].name')

  if [ "$latest_version" != "null" ]; then
    echo "Found \"$resource_name\" with latest version: $latest_version"
    echo "Downloading \"$resource_name\" from Hangar..."
    curl -L "https://hangar.papermc.io/api/v1/projects/$namespace/versions/$latest_version/download" -o "$RESOURCE_DIR/$resource_name-$latest_version.jar"
    echo "✅ Plugin \"$resource_name\" downloaded to $RESOURCE_DIR/$resource_name-$latest_version.jar"
    return 0
  else
    echo "❌ No plugin found on Hangar for \"$resource_name\"."
    return 1
  fi
}

# Function to install from Modrinth
install_from_modrinth() {
  local resource_name=$1
  echo "Searching for \"$resource_name\" on Modrinth..."
  local mod_data=$(curl -s "https://api.modrinth.com/v2/project/$resource_name")

  if [ "$(echo "$mod_data" | jq -r '.id')" != "null" ]; then
    local mod_name=$(echo "$mod_data" | jq -r '.title')
    local latest_version=$(curl -s "https://api.modrinth.com/v2/project/$resource_name/version" | jq -r '.[0].id')
    local mod_url=$(curl -s "https://api.modrinth.com/v2/version/$latest_version" | jq -r '.files[0].url')
    echo "Found mod: $mod_name"
    echo "Downloading \"$mod_name\" from Modrinth..."
    curl -L "$mod_url" -o "$RESOURCE_DIR/$mod_name.jar"
    echo "✅ Mod \"$mod_name\" downloaded to $RESOURCE_DIR/$mod_name.jar"
    return 0
  else
    echo "❌ No mod found on Modrinth for \"$resource_name\"."
    return 1
  fi
}

# Unified installation function
install_resource() {
  clear_screen
  echo "🔍 Unified Search: SpigotMC, Hangar, Modrinth"
  read -p "Enter the name or slug of the plugin/mod: " resource_name

  echo "Attempting to install \"$resource_name\"..."
  
  # Try SpigotMC
  install_from_spigot "$resource_name" && return

  # Try Hangar
  install_from_hangar "$resource_name" && return

  # Try Modrinth
  install_from_modrinth "$resource_name" && return

  echo "❌ Resource \"$resource_name\" could not be found on any platform."
}

# Function to display the resource directory
show_downloaded_resources() {
  clear_screen
  echo "📂 Downloaded Resources in $RESOURCE_DIR:"
  ls "$RESOURCE_DIR" || echo "No resources found."
}

# Main menu loop
while true; do
  clear_screen
  echo "1️⃣  Install Plugin or Mod (Unified Search)"
  echo "2️⃣  Show Downloaded Resources"
  echo "3️⃣  Clear All Downloaded Resources"
  echo "4️⃣  Exit"
  echo "============================="
  read -p "Choose an option: " choice

  case $choice in
    1) install_resource ;;
    2) show_downloaded_resources ;;
    3) 
       read -p "Are you sure you want to clear all downloaded resources? (y/n): " confirm
       if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
         rm -rf "$RESOURCE_DIR"/*
         echo "✅ All downloaded resources cleared."
         sleep 2
       else
         echo "❌ Clear operation cancelled."
         sleep 2
       fi
       ;;
    4) echo "Exiting. Goodbye!"; exit 0 ;;
    *) echo "❌ Invalid choice. Please try again."; sleep 2 ;;
  esac
done
