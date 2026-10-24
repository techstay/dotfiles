# dotfiles

Personal dotfiles repository, declaratively managed with [mise](https://mise.jdx.dev/) for development runtimes, modern CLI toolchains, and modular desktop environment dotfile deployment.

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

# Run full setup (auto-detects distribution & desktop environment)
mise run setup

# Or perform steps individually:
# 1. Install declared toolchains (Node, pnpm, starship, bat, ripgrep, btop, lazygit, etc.)
mise install

# 2. Deploy all dotfile symlinks to $HOME and ~/.config (respecting MISE_ENV)
mise dot apply
```

---

## 🖥️ Modular Desktop Architecture (`MISE_ENV`)

Configurations are strictly decoupled between **General Base**, **KDE Plasma**, and **GNOME** desktop environments:

```
~/.dotfiles/
├── .config/
│   ├── mise/
│   │   ├── config.toml       # Base configuration: tools, shell, terminals, editors
│   │   ├── mise.kde.toml     # KDE Plasma 6: KWin effects, tiling, shortcuts, fcitx5 tasks
│   │   └── mise.gnome.toml   # GNOME: Burn My Windows extension profiles
│   ├── kde/
│   │   ├── kwinrc            # KWin effects, tiling ratio, Xwayland HiDPI scale
│   │   └── kglobalshortcutsrc# Global desktop & window management shortcuts
│   └── burn-my-windows/      # GNOME window animation profiles
```

The desktop environment is automatically detected in `~/.zshrc` and `config.fish` (`MISE_ENV=kde` or `MISE_ENV=gnome`). You can also specify it explicitly:

```bash
# Apply KDE configuration
MISE_ENV=kde mise dot apply

# Apply GNOME configuration
MISE_ENV=gnome mise dot apply
```

---

## 📦 Managed Configurations

The repository manages core configurations separated by concern:

| Category | Target Path | Layer | Description |
| :--- | :--- | :--- | :--- |
| **Tool & Dotfile Management** | `~/.config/mise/config.toml` | Base | Mise tools definition and base dotfile mappings |
| | `~/.config/mise/mise.kde.toml` | KDE Layer | KDE Plasma 6 specific configurations & maintenance tasks |
| | `~/.config/mise/mise.gnome.toml` | GNOME Layer | GNOME Shell extension profiles |
| **KDE Plasma 6 (Desktop)** | `~/.config/kwinrc` | KDE Layer | KWin effects, tiling splits, Xwayland 2x HiDPI, Wayland launcher |
| | `~/.config/kglobalshortcutsrc` | KDE Layer | Global keyboard shortcuts for tiling, cube, overview |
| **GNOME (Desktop)** | `~/.config/burn-my-windows/profiles/*.conf` | GNOME Layer | Burn My Windows window animation profiles |
| **Shell & Prompt** | `~/.zshrc` | Base | Zsh configuration (Zim, eza, fzf, bat) |
| | `~/.zimrc` | Base | Zim module declarations |
| | `~/.p10k.zsh` | Base | Powerlevel10k theme configuration |
| | `~/.config/fish/config.fish` | Base | Fish shell aliases and environment initialization |
| **Terminal Emulators** | `~/.config/ghostty/config` | Base | Ghostty (TokyoNight Moon theme, JetBrainsMono Nerd Font) |
| | `~/.config/kitty/kitty.conf` | Base | Kitty terminal configuration |
| | `~/.config/alacritty/alacritty.yml` | Base | Alacritty terminal configuration |
| **Editor** | `~/.config/zed/settings.json` | Base | Zed editor (VSCode keybindings, One Dark theme) |
| **Version Control & CLI** | `~/.gitconfig` | Base | Git global configuration (aliases, default branches) |
| | `~/.config/gitmoji-nodejs/config.json` | Base | Gitmoji commit emoji configuration |
| | `~/.config/fastfetch/config.jsonc` | Base | Fastfetch system information display layout |
| **Input Method (Fcitx5 & Rime)** | `~/.config/fcitx5/config` | Base | Fcitx5 shortcuts and core behavior settings |
| | `~/.config/fcitx5/profile` | Base | Input method list (Default US + Mint Rime Double Pinyin) |
| | `~/.config/fcitx5/conf/classicui.conf` | Base | UI theme (Mint Dark Green, MiSans font, 9 candidates) |
| | `~/.config/fcitx5/conf/notifications.conf`| Base | Notification suppression (KDE / GNOME diagnostic warnings) |
| | `~/.local/share/fcitx5/rime/default.custom.yaml` | Base | Rime global overrides (Xiaohe double pinyin, 9 candidates) |
| | `~/.local/share/fcitx5/rime/double_pinyin_flypy.custom.yaml` | Base | Xiaohe double pinyin custom page size (9 candidates) |
| | `~/.local/share/fcitx5/rime/rime_mint.custom.yaml` | Base | Mint full pinyin custom page size (9 candidates) |
| | `~/.local/share/fcitx5/rime/rime_mint_flypy.custom.yaml` | Base | Mint double pinyin custom page size (9 candidates) |
| | `~/.local/share/fcitx5/rime/weasel.custom.yaml` | Base | Weasel frontend style override (MiSans font, mint_dark_green) |
| **System & Environment** | `~/.config/fontconfig/fonts.conf` | Base | Fontconfig rendering, CJK fallback chains, and alias rules |
| | `~/.config/environment.d/im.conf` | Base | Clean Wayland input method environment variables |
| | `~/.ssh/config` | Base | SSH client host configurations |
| | `~/.proxy.sh` | Base | Shell proxy environment toggle helper |

---

## 🛠️ Daily Workflow & Maintenance

All operations are driven by `mise`:

```bash
# Check the deployment status and differences
mise dot status
mise dot diff

# Apply pending updates or restore symlinks
mise dot apply

# Force overwrite conflicting files and deploy
mise dot apply --force --yes

# Cleanly restart Fcitx5 via KWin Wayland Launcher (KDE task)
mise run fcitx5:restart
```

---

## ⌨️ Input Method & Desktop Notes

Configured for **Arch Linux & Fedora (Wayland - KDE Plasma 6 / GNOME)**:
- **Input Method**: Fcitx 5 powered by Rime (Mint Pinyin / Oh-My-Rime schema with Xiaohe Double Pinyin and Wanxiang dictionary).
- **Theme**: `mint-dark-green` (`fcitx5-theme-mint`) deployed to `~/.local/share/fcitx5/themes/`.
- **Fonts**:
  - `MiSans`: Primary font for Fcitx5 candidates and UI.
  - `JetBrainsMono Nerd Font`: Used in Ghostty and Zed.
  - `MesloLGS NF`: Used in Kitty, Alacritty, and Powerlevel10k.
- **Wayland Protocol**: In KDE Plasma 6 Wayland session, native Wayland `text-input-v3` is utilized without legacy `QT_IM_MODULE` conflicts.
