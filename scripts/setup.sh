#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Dotfiles Setup & Dependency Installer
# Supports Arch Linux & Fedora
# ==============================================================================

BOLD="$(tput bold 2>/dev/null || true)"
GREEN="$(tput setaf 2 2>/dev/null || true)"
YELLOW="$(tput setaf 3 2>/dev/null || true)"
BLUE="$(tput setaf 4 2>/dev/null || true)"
RESET="$(tput sgr0 2>/dev/null || true)"

log() { echo -e "${GREEN}==>${RESET} ${BOLD}$1${RESET}"; }
warn() { echo -e "${YELLOW}WARNING:${RESET} $1"; }
info() { echo -e "${BLUE}::${RESET} $1"; }

# 1. System Package Installation
install_system_packages() {
  log "Installing system packages..."
  if command -v pacman >/dev/null 2>&1; then
    info "Detected Arch Linux (pacman)"
    local pkgs=(
      base-devel
      git
      curl
      wget
      unzip
      # Fcitx5 Input Method ecosystem
      fcitx5
      fcitx5-im
      fcitx5-chinese-addons
      fcitx5-rime
      fcitx5-lua
      # Fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      # Shells & Terminals
      zsh
      zsh-completions
      fish
      fastfetch
      kitty
      alacritty
    )
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  elif command -v dnf >/dev/null 2>&1; then
    info "Detected Fedora (dnf)"
    local pkgs=(
      @development-tools
      git
      curl
      wget
      unzip
      fcitx5
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-autostart
      google-noto-sans-cjk-fonts
      google-noto-color-emoji-fonts
      zsh
      fish
      fastfetch
      kitty
      alacritty
    )
    sudo dnf install -y "${pkgs[@]}"
  else
    warn "Unrecognized package manager. Please install fcitx5 and system fonts manually."
  fi
}

# 2. Font Installation (User-space)
install_fonts() {
  log "Installing user fonts (JetBrainsMono Nerd Font & MesloLGS NF)..."
  local font_dir="$HOME/.local/share/fonts"
  mkdir -p "$font_dir"

  # JetBrainsMono Nerd Font
  if [ ! -d "$font_dir/JetBrainsMono" ]; then
    info "Downloading JetBrainsMono Nerd Font..."
    mkdir -p "$font_dir/JetBrainsMono"
    curl -fSL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.tar.xz" \
      | tar -xJ -C "$font_dir/JetBrainsMono"
  else
    info "JetBrainsMono Nerd Font already installed."
  fi

  # MesloLGS NF (Powerlevel10k recommended)
  if [ ! -d "$font_dir/MesloLGSNF" ]; then
    info "Downloading MesloLGS NF..."
    mkdir -p "$font_dir/MesloLGSNF"
    local base_url="https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master"
    for style in "Regular" "Bold" "Italic" "Bold%20Italic"; do
      local filename="MesloLGS NF ${style//%20/ }.ttf"
      curl -fSL -o "$font_dir/MesloLGSNF/$filename" "$base_url/MesloLGS%20NF%20$style.ttf"
    done
  else
    info "MesloLGS NF already installed."
  fi

  # Refresh Fontconfig cache
  if command -v fc-cache >/dev/null 2>&1; then
    info "Updating font cache..."
    fc-cache -f "$font_dir"
  fi
}

# 3. Fcitx5 Theme & Rime (Oh-My-Rime / Mint Pinyin)
install_fcitx_extras() {
  log "Installing Fcitx5 theme and Rime dictionary schemas..."
  local themes_dir="$HOME/.local/share/fcitx5/themes"
  mkdir -p "$themes_dir"

  # Mint theme
  if [ ! -d "$themes_dir/mint-green-dark" ]; then
    info "Cloning fcitx5-theme-mint..."
    git clone --depth=1 https://github.com/witt-bit/fcitx5-theme-mint /tmp/fcitx5-theme-mint
    cp -r /tmp/fcitx5-theme-mint/mint-* "$themes_dir/"
    ln -sfn mint-green-dark "$themes_dir/mint-dark-green"
    rm -rf /tmp/fcitx5-theme-mint
  else
    info "fcitx5-theme-mint already installed."
  fi

  # Oh-my-rime (Mint Pinyin)
  local rime_dir="$HOME/.local/share/rime"
  if [ ! -d "$rime_dir" ] || [ ! -f "$rime_dir/default.yaml" ]; then
    info "Cloning oh-my-rime (Mint Pinyin)..."
    rm -rf "$rime_dir"
    git clone --depth=1 https://github.com/Mintimate/oh-my-rime "$rime_dir"
    mkdir -p "$HOME/.local/share/fcitx5"
    ln -sfn "$rime_dir" "$HOME/.local/share/fcitx5/rime"
  else
    info "oh-my-rime already installed."
  fi
}

# 4. Global Tooling (pnpm gitmoji-cli, etc.)
install_cli_tools() {
  log "Installing global CLI tools..."
  if command -v pnpm >/dev/null 2>&1; then
    local pnpm_home="${PNPM_HOME:-$HOME/.local/share/pnpm}"
    mkdir -p "$pnpm_home" "$HOME/.local/bin"
    export PNPM_HOME="$pnpm_home"
    export PATH="$PNPM_HOME:$PATH"
    pnpm config set global-bin-dir "$pnpm_home" 2>/dev/null || true
    if ! command -v gitmoji >/dev/null 2>&1; then
      info "Installing gitmoji-cli via pnpm..."
      pnpm add -g gitmoji-cli
      ln -sf "$pnpm_home/gitmoji" "$HOME/.local/bin/gitmoji"
    fi
  fi
}

# 5. Apply mise tools & dotfiles
deploy_mise() {
  log "Installing mise tools and applying dotfile symlinks..."
  if command -v mise >/dev/null 2>&1; then
    mise install -y
    mise dot apply --yes
  fi
}

main() {
  echo -e "${BOLD}${GREEN}=====================================================${RESET}"
  echo -e "${BOLD}${GREEN}           Starting Dotfiles Bootstrap               ${RESET}"
  echo -e "${BOLD}${GREEN}=====================================================${RESET}"

  # Prompt for sudo if needed
  if command -v sudo >/dev/null 2>&1; then
    sudo -v || true
  fi

  install_system_packages
  install_fonts
  install_fcitx_extras
  install_cli_tools
  deploy_mise

  echo -e "\n${BOLD}${GREEN}✨ Bootstrap complete!${RESET}"
  echo -e "Tip: You may restart your desktop session or reboot to ensure Fcitx5 environment variables are active.\n"
}

main "$@"
