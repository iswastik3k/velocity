#!/bin/bash

set -e

# === COLORS ===
LAVENDER='\033[38;2;180;190;254m'
MAUVE='\033[38;2;203;166;247m'
GREEN='\033[38;2;166;227;161m'
RED='\033[38;2;243;139;168m'
TEXT='\033[38;2;205;214;244m'
DIM='\033[38;2;108;112;134m'
RESET='\033[0m'

# === HELPERS ===
info()    { echo -e "${LAVENDER}  ${TEXT}$1${RESET}"; }
success() { echo -e "${GREEN}  ${TEXT}$1${RESET}"; }
warning() { echo -e "${MAUVE}  ${TEXT}$1${RESET}"; }
error()   { echo -e "${RED}  ${TEXT}$1${RESET}"; }
dim()     { echo -e "${DIM}$1${RESET}"; }

# === BANNER ===
echo -e "${LAVENDER}"
figlet -f slant "VELOCITY"
echo -e "${RESET}"
dim "  Catppuccin Mocha × Hollow Knight"
dim "  Arch Linux dotfiles by iswastik3k"
echo ""

# === CHECKS ===
info "Checking system..."

if ! command -v pacman &> /dev/null; then
    error "This installer is for Arch Linux only."
    exit 1
fi

if ! command -v yay &> /dev/null; then
    warning "yay not found. Installing yay..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd - > /dev/null
    success "yay installed."
fi

success "System checks passed."
echo ""

# === PACKAGES ===
info "Installing packages..."
yay -S --needed --noconfirm - < packages.txt
success "Packages installed."
echo ""

# === DOTFILES ===
info "Deploying dotfiles..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

deploy() {
    local src="$DOTFILES_DIR/home/$1"
    local dst="$HOME_DIR/$1"
    local dir="$(dirname "$dst")"

    if [ ! -e "$src" ]; then
        warning "Source not found, skipping: $1"
        return
    fi

    mkdir -p "$dir"

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        warning "Backing up existing: $1 → ${backup##*/}"
        mv "$dst" "$backup"
    fi

    ln -sf "$src" "$dst"
    success "Linked: $1"
}

# Config files
deploy ".config/hypr/hyprland.lua"
deploy ".config/hypr/hyprlock.conf"
deploy ".config/hypr/hypridle.conf"
deploy ".config/waybar/config.jsonc"
deploy ".config/waybar/style.css"
deploy ".config/kitty/kitty.conf"
deploy ".config/wofi/config"
deploy ".config/wofi/style.css"
deploy ".config/wofi/power.css"
deploy ".config/dunst/dunstrc"
deploy ".config/fastfetch/config.jsonc"
deploy ".config/starship.toml"
deploy ".config/yazi/yazi.toml"
deploy ".config/yazi/keymap.toml"
deploy ".config/yazi/theme.toml"
deploy ".zshrc"
deploy ".local/bin/powermenu.sh"

echo ""

# === PERMISSIONS ===
info "Setting permissions..."
chmod +x "$HOME/.local/bin/powermenu.sh"
success "Permissions set."
echo ""

# === SHELL ===
if [ "$SHELL" != "$(which zsh)" ]; then
    info "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    success "Default shell set to zsh."
else
    success "zsh is already default shell."
fi
echo ""

# === SDDM ===
info "Configuring SDDM..."
if [ ! -f /etc/sddm.conf ]; then
    sudo bash -c 'cat > /etc/sddm.conf << SDDMEOF
[Theme]
Current=catppuccin-mocha-lavender

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
SDDMEOF'
    success "SDDM configured."
else
    warning "SDDM config already exists at /etc/sddm.conf — skipping."
fi

sudo systemctl enable sddm 2>/dev/null || true
echo ""

# === GTK ===
info "Configuring GTK theme..."

mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/gtk-4.0"

cat > "$HOME/.config/gtk-3.0/settings.ini" << GTKEOF
[Settings]
gtk-theme-name = catppuccin-mocha-lavender-standard+default
gtk-icon-theme-name = Papirus-Dark
gtk-cursor-theme-name = catppuccin-mocha-lavender-cursors
gtk-cursor-theme-size = 24
gtk-font-name = JetBrainsMono Nerd Font 11
gtk-application-prefer-dark-theme = true
gtk-button-images = false
gtk-menu-images = false
gtk-enable-animations = true
GTKEOF

cat > "$HOME/.config/gtk-4.0/settings.ini" << GTKEOF
[Settings]
gtk-theme-name = catppuccin-mocha-lavender-standard+default
gtk-icon-theme-name = Papirus-Dark
gtk-cursor-theme-name = catppuccin-mocha-lavender-cursors
gtk-cursor-theme-size = 24
gtk-font-name = JetBrainsMono Nerd Font 11
gtk-application-prefer-dark-theme = true
GTKEOF

gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-lavender-standard+default' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme 'catppuccin-mocha-lavender-cursors' 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 11' 2>/dev/null || true

success "GTK theme configured."
echo ""

# === ZINIT ===
info "Installing zinit..."
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    success "Zinit installed."
else
    success "Zinit already installed."
fi
echo ""

# === YAZI PLUGINS ===
info "Installing yazi plugins..."
if command -v ya &> /dev/null; then
    ya pack -a yazi-rs/flavors#catppuccin-mocha 2>/dev/null || warning "Catppuccin flavor install failed — install manually."
    ya pack -a yazi-rs/plugins#zoxide 2>/dev/null || warning "Zoxide plugin install failed — install manually."
    success "Yazi plugins installed."
else
    warning "ya not found — install yazi plugins manually after launch."
fi
echo ""

# === WALLPAPER ===
info "Wallpaper setup..."
mkdir -p "$HOME/Pictures"
if [ -f "$DOTFILES_DIR/assets/hollow-knight.jpg" ]; then
    cp "$DOTFILES_DIR/assets/hollow-knight.jpg" "$HOME/Pictures/hollow-knight.jpg"
    success "Wallpaper copied to ~/Pictures/"
else
    warning "Wallpaper not found in assets/ — copy hollow-knight.jpg to ~/Pictures/ manually."
fi
echo ""

# === DONE ===
echo -e "${LAVENDER}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
success "VELOCITY installed successfully."
echo ""
dim "  Next steps:"
dim "  1. Copy your wallpaper to ~/Pictures/hollow-knight.jpg if not done"
dim "  2. Log out and back in, or reboot"
dim "  3. Select Hyprland from SDDM"
dim "  4. Launch kitty and run: source ~/.zshrc"
echo ""
echo -e "${LAVENDER}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
EOF

chmod +x install.sh
