# dotfiles

Personal dotfiles repository, declaratively managed with [mise](https://mise.jdx.dev/) for development runtimes, CLI toolchains, and dotfile symlink deployment.

---

## 🚀 Quick Start

### 1. Install mise

If `mise` is not installed on your system:

```bash
curl https://mise.run | sh

# Ensure ~/.local/bin is in your PATH (configured in ~/.zshrc and ~/.config/fish/config.fish)
export PATH="$HOME/.local/bin:$PATH"
```

### 2. Clone the Repository

Clone this repository into `~/.dotfiles`:

```bash
git clone git@github.com:techstay/dotfiles.git ~/.dotfiles
```

### 3. Install Toolchains, Dependencies & Deploy Dotfiles

Navigate to the repository directory, then run the setup task or execute commands:

```bash
cd ~/.dotfiles

# Run full setup (installs system packages, user fonts, fcitx5 themes/rime, tools, and symlinks)
mise run setup

# Or perform steps individually:
# 1. Install declared toolchains (Node, pnpm, starship, lazygit, jujutsu, etc.)
mise install

# 2. Deploy all dotfile symlinks to $HOME and ~/.config
mise dot apply
```

---

## 📦 Managed Configurations

The repository currently manages 25 configuration files:

| Category | Target Path | Description |
| :--- | :--- | :--- |
| **Tool & Dotfile Management** | `~/.config/mise/config.toml` | Mise tools definition and dotfile symlink mappings |
| **Shell & Prompt** | `~/.zshrc` | Zsh main config (Zim framework, eza/fzf/mise integration) |
| | `~/.zimrc` | Zim module declarations |
| | `~/.p10k.zsh` | Powerlevel10k theme configuration |
| | `~/.config/fish/config.fish` | Fish shell aliases and environment initialization |
| **Terminal Emulators** | `~/.config/ghostty/config` | Ghostty (TokyoNight Moon theme, JetBrainsMono Nerd Font) |
| | `~/.config/kitty/kitty.conf` | Kitty terminal configuration |
| | `~/.config/alacritty/alacritty.yml` | Alacritty terminal configuration |
| **Editor** | `~/.config/zed/settings.json` | Zed editor (VSCode keybindings, One Dark theme) |
| **Version Control & CLI** | `~/.gitconfig` | Git global configuration (aliases, default branches) |
| | `~/.config/gitmoji-nodejs/config.json` | Gitmoji commit emoji configuration |
| | `~/.config/fastfetch/config.jsonc` | Fastfetch system information display layout |
| **Input Method (Fcitx5 & Rime)** | `~/.config/fcitx5/config` | Fcitx5 shortcuts and core behavior settings |
| | `~/.config/fcitx5/profile` | Input method list (Default US + Mint Rime Double Pinyin) |
| | `~/.config/fcitx5/conf/classicui.conf` | UI theme (Mint Dark Green, MiSans font, 9 candidates) |
| | `~/.config/fcitx5/conf/notifications.conf`| Notification suppression and diagnostics settings |
| | `~/.local/share/fcitx5/rime/default.custom.yaml` | Rime global overrides (Xiaohe double pinyin, 9 candidates) |
| | `~/.local/share/fcitx5/rime/double_pinyin_flypy.custom.yaml` | Xiaohe double pinyin custom page size (9 candidates) |
| | `~/.local/share/fcitx5/rime/rime_mint.custom.yaml` | Mint full pinyin custom page size (9 candidates) |
| | `~/.local/share/fcitx5/rime/rime_mint_flypy.custom.yaml` | Mint double pinyin custom page size (9 candidates) |
| | `~/.local/share/fcitx5/rime/weasel.custom.yaml` | Weasel frontend style override (MiSans font, mint_dark_green) |
| **System & Desktop** | `~/.config/environment.d/im.conf` | Recommended Wayland input method environment variables |
| | `~/.config/burn-my-windows/profiles/*.conf` | Burn My Windows GNOME extension profile |
| | `~/.ssh/config` | SSH client host configurations |
| | `~/.proxy.sh` | Shell proxy environment toggle helper |

---

## 🛠️ Daily Workflow & Maintenance

All dotfile operations are driven by `mise dot` (alias for `mise dotfiles`):

```bash
# Check the deployment status and differences
mise dot status
mise dot diff

# Track a new configuration file (moves to ~/.dotfiles and symlinks back)
mise dot add ~/.config/xxx/config

# Apply pending updates or restore missing symlinks
mise dot apply

# Force overwrite conflicting files and deploy
mise dot apply --force --yes
```

---

## ⌨️ Input Method & Desktop Notes

Configured for **Arch Linux & Fedora (Wayland - KDE Plasma / GNOME)**:
- **Input Method**: Fcitx 5 powered by Rime (Mint Pinyin / Oh-My-Rime schema with Xiaohe Double Pinyin and Wanxiang dictionary).
- **Theme**: `mint-dark-green` (`fcitx5-theme-mint`) deployed to `~/.local/share/fcitx5/themes/`.
- **Fonts**:
  - `MiSans`: Primary font for Fcitx5 candidates and UI.
  - `JetBrainsMono Nerd Font`: Used in Ghostty and Zed.
  - `MesloLGS NF`: Used in Kitty, Alacritty, and Powerlevel10k.
- **Environment Variables**: Managed via `~/.config/environment.d/im.conf` following the official Fcitx 5 Wayland recommendations to ensure smooth integration without legacy `GTK_IM_MODULE` issues.
