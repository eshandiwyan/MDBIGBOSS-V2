#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Header
echo -e "${GREEN}"
echo -e "┌────────────────────────────────────────────────────┐"
echo -e "│      Termux Media Downloader Installation          │"
echo -e "│               by BIG BOSS                       │"
echo -e "│                                                              │"
echo -e "└────────────────────────────────────────────────────┘"
echo -e "${NC}"

# Check if running in Termux
if ! [ -x "$(command -v termux-setup-storage)" ]; then
  echo -e "${RED}Error: This script must be run in Termux${NC}"
  exit 1
fi

# Update and install required packages
echo -e "${YELLOW}[*] Updating packages...${NC}"
apt update -y && apt upgrade -y
pkg update -y && pkg upgrade -y
echo -e "${YELLOW}[*] Installing dependencies...${NC}"
apt install -y python ffmpeg curl

echo -e "${YELLOW}[*] Installing yt-dlp...${NC}"
pip install --upgrade yt-dlp

# Setup storage if needed
echo -e "${YELLOW}[*] Checking storage permissions...${NC}"
if [ ! -d "$HOME/storage" ]; then
    echo -e "${BLUE}[*] Setting up storage access...${NC}"
    yes | termux-setup-storage
    sleep 2  # Give it time to complete
    mkdir -p ~/storage/shared/TDownloads
  else
    mkdir -p ~/storage/shared/TDownloads
fi

# Install main script
echo -e "${YELLOW}[*] Downloading and installing Termux Media Downloader...${NC}"
curl -L "https://raw.githubusercontent.com/eshandiwyan/MDBIGBOSS-V2/main/tmd.sh" -o $PREFIX/bin/tmd
chmod +x $PREFIX/bin/tmd

# Create config directory
echo -e "${YELLOW}[*] Setting up configuration directory...${NC}"
mkdir -p $HOME/.config/tmd_config

# Completion message
echo -e "${GREEN}"
echo -e "┌────────────────────────────────────────────────────┐"
echo -e "│          Installation Completed Successfully!      │"
echo -e "│                                                    │"
echo -e "│   To start using the media downloader, run:        │"
echo -e "│         ${YELLOW}tmd${GREEN}                                        │"
echo -e "│                                                    │"
echo -e "│   This will create the configuration file and      │"
echo -e "│   set your preferred download directory.           │"
echo -e "│                                                    │"
echo -e "│   Default download location:                       │"
echo -e "│   ${YELLOW}/sdcard/TDownloads${GREEN}                        │"
echo -e "└────────────────────────────────────────────────────┘"
echo -e "${NC}"
