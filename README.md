# Arch Linux + i3 Setup Script

Welcome! This repository contains a convenient **setup script** to automate the installation and configuration of essential software on a fresh Arch Linux installation with i3 window manager.

**Configured for my ThinkPad - USE AT YOUR OWN RISK!**

---

## What This Script Does

- Updates your system packages
- Installs your list of official Arch packages (`pkglist.txt`)
- Installs `yay` (an AUR helper) if missing
- Installs AUR packages (`aurlist.txt`)
- Sets up **LazyVim** Neovim configuration
- Downloads and installs MesloLGS Nerd Fonts required by the Tide prompt theme
- Installs **Fish shell** utilities: Fisher plugin manager and Tide prompt
- Optionally sets Fish as your default shell

---

## Prerequisites

- A **fresh Arch Linux installation** (or an existing install you want to configure)
- i3 window manager installed
- A user with `sudo` privileges
- Internet connection

---

## How to Use

1. **Clone this repository:**
```shell
  git clone https://github.com/seumak/.dotfiles.git ~/.dotfiles
  cd ~/.dotfiles
```

2. **Make the setup script executable:**
```shell
  chmod +x setup.sh
```

3. **Run the setup script:**
```shell
  ./setup.sh

```
4. **Restart your terminal or log out and log back in to apply shell and font changes.**

5. **Move the .configs from the repo (fish, i3, i3status and rofi) into your system .config** - If you want my setup. If not, configure to your liking.

----
**Note:**
- You may need to set shell to fish manually after the install.
