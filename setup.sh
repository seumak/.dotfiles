#!/bin/bash
# setup.sh — Arch Linux Setup Script with i3 and yay
# Author: セウマク
# Save this in ~/.dotfiles/ and run after a fresh Arch + i3 install

set -e

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔧 Starting Arch Linux setup...${NC}"

# Step 1: Update the system
echo -e "${GREEN}📦 Updating system packages...${NC}"
sudo pacman -Syu --noconfirm

# Step 2: Install official repo packages
if [[ -f pkglist.txt ]]; then
  echo -e "${GREEN}📂 Installing official packages from pkglist.txt...${NC}"
  sudo pacman -S --needed --noconfirm - <pkglist.txt
else
  echo "⚠️  pkglist.txt not found!"
fi

# Step 3: Install yay if not already installed
if ! command -v yay &>/dev/null; then
  echo -e "${GREEN}🌐 yay not found. Installing yay (AUR helper)...${NC}"
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd "/tmp/yay"
  makepkg -si --noconfirm
  cd ~
  rm -rf /tmp/yay
else
  echo -e "${GREEN}✅ yay is already installed.${NC}"
fi

# Step 4: Install AUR packages
if [[ -f aurlist.txt ]]; then
  echo -e "${GREEN}📂 Installing AUR packages from aurlist.txt...${NC}"
  yay -S --needed --noconfirm - <aurlist.txt
else
  echo "⚠️  aurlist.txt not found!"
fi

# Step 5: Install Lazyvim
echo -e "${GREEN}🧠 Setting up LazyVim (Neovim config)...${NC}"
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
else
  echo -e "${YELLOW}⚠️  ~/.config/nvim already exists. Skipping LazyVim install.${NC}"
fi

# Step 6: Install Fonts for Tide:
install_tide_fonts() {
  echo -e "${GREEN}🔤 Installing MesloLGS NF fonts for Tide...${NC}"

  FONT_DIR="$HOME/.local/share/fonts"
  MESLO_URL_BASE="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Regular/complete"

  mkdir -p "$FONT_DIR"

  # List of required font files
  fonts=(
    "MesloLGS%20NF%20Regular.ttf"
    "MesloLGS%20NF%20Bold.ttf"
    "MesloLGS%20NF%20Italic.ttf"
    "MesloLGS%20NF%20Bold%20Italic.ttf"
  )

  for font in "${fonts[@]}"; do
    dest_file="${font//%20/ }"
    echo -e "⬇️  Downloading $dest_file..."
    curl -fsSL "$MESLO_URL_BASE/$font" -o "$FONT_DIR/$dest_file"
  done

  echo -e "${GREEN}✅ Fonts downloaded. Refreshing font cache...${NC}"
  fc-cache -fv >/dev/null
}

install_tide_fonts

# Step 7: Install Fisher & Tide
echo -e "${GREEN}🎣 Installing Fisher & Tide for Fish shell...${NC}"
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
fish -c 'fisher install IlanCosman/tide'

# Optional: Set fish as default shell
echo -e "${GREEN}🐟 Setting fish as default shell...${NC}"
chsh -s /usr/bin/fish || echo "⚠️  Failed to change shell. Please do it manually."

echo -e "${GREEN}✅ Setup complete. Enjoy your system!${NC}"
