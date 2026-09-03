#!/bin/bash

# ===== VELOCITY — Rosé Pine Moon =====
# Dotfiles installer for Arch Linux
# https://github.com/iswastik3k/velocity/tree/variants/rose-pine

set -e

# === COLORS ===
ROSE='\033[38;2;234;154;151m'
IRIS='\033[38;2;196;167;231m'
GOLD='\033[38;2;246;193;119m'
LOVE='\033[38;2;235;111;146m'
TEXT='\033[38;2;224;222;244m'
DIM='\033[38;2;110;106;134m'
RESET='\033[0m'

info()    { echo -e "${ROSE}  ${TEXT}$1${RESET}"; }
success() { echo -e "${IRIS}  ${TEXT}$1${RESET}"; }
warning() { echo -e "${GOLD}  ${TEXT}$1${RESET}"; }
error()   { echo -e "${LOVE}  ${TEXT}$1${RESET}"; }
dim()     { echo -e "${DIM}$1${RESET}"; }

# === BANNER ===
echo -e "${ROSE}"
if command -v figlet &> /dev/null; then
    figlet -f slant "VELOCITY"
else
    echo "VELOCITY"
fi
echo -e "${RESET}"
dim "  Rosé Pine Moon"
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
grep -vE "^s*#|^s*$" packages.txt | yay -S --needed --noconfirm -
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

deploy ".config/hypr/hyprland.lua"
deploy ".config/hypr/hyprlock.conf"
deploy ".config/hypr/hypridle.conf"
deploy ".config/waybar/config.jsonc"
deploy ".config/waybar/style.css"
deploy ".config/alacritty/alacritty.toml"
deploy ".config/wofi/config"
deploy ".config/wofi/style.css"
deploy ".config/wofi/power.css"
deploy ".config/dunst/dunstrc"
deploy ".config/fastfetch/config.jsonc"
deploy ".config/starship.toml"
deploy ".config/fontconfig/fonts.conf"
deploy ".config/Code/User/settings.json"
deploy ".config/Code/User/keybindings.json"
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

# === FONT CACHE ===
info "Rebuilding font cache..."
fc-cache -f
success "Font cache rebuilt."
echo ""

# === ROSÉ PINE MANUAL ASSETS ===
info "Installing Rosé Pine theme assets from GitHub..."

# Kvantum theme
mkdir -p "$HOME/.config/Kvantum"
if [ ! -d "$HOME/.config/Kvantum/rose-pine-moon-rose" ]; then
    git clone --depth 1 https://github.com/rose-pine/kvantum.git /tmp/rose-pine-kvantum 2>/dev/null
    if [ -d /tmp/rose-pine-kvantum ]; then
        cp -r /tmp/rose-pine-kvantum/* "$HOME/.config/Kvantum/" 2>/dev/null
        success "Kvantum Rosé Pine theme installed."
    else
        warning "Kvantum theme clone failed — install manually from github.com/rose-pine/kvantum"
    fi
else
    success "Kvantum Rosé Pine theme already present."
fi

# SDDM theme
if [ ! -d /usr/share/sddm/themes/rose-pine ]; then
    git clone --depth 1 https://github.com/lwndhrst/sddm-rose-pine.git /tmp/sddm-rose-pine 2>/dev/null
    if [ -d /tmp/sddm-rose-pine ]; then
        sudo mkdir -p /usr/share/sddm/themes/rose-pine
        sudo cp -r /tmp/sddm-rose-pine/* /usr/share/sddm/themes/rose-pine/
        success "SDDM Rosé Pine theme installed."
    else
        warning "SDDM theme clone failed — install manually from github.com/lwndhrst/sddm-rose-pine"
    fi
else
    warning "SDDM Rosé Pine theme already present — skipping."
fi
echo ""

# === SDDM ===
info "Configuring SDDM..."
if [ ! -f /etc/sddm.conf ]; then
    sudo bash -c 'cat > /etc/sddm.conf << SDDMEOF
[Theme]
Current=rose-pine

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

# === GTK / QT ===
info "Configuring GTK and Qt theme..."

mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/gtk-4.0"

cat > "$HOME/.config/gtk-3.0/settings.ini" << GTKEOF
[Settings]
gtk-theme-name=rose-pine-moon-gtk
gtk-icon-theme-name=rose-pine-moon-icons
gtk-cursor-theme-name=rose-pine-hyprcursor
gtk-cursor-theme-size=24
gtk-font-name=Inter 10
gtk-application-prefer-dark-theme=1
gtk-button-images=0
gtk-menu-images=0
gtk-enable-event-sounds=0
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
GTKEOF

cat > "$HOME/.config/gtk-4.0/settings.ini" << GTKEOF
[Settings]
gtk-theme-name=rose-pine-moon-gtk
gtk-icon-theme-name=rose-pine-moon-icons
gtk-cursor-theme-name=rose-pine-hyprcursor
gtk-cursor-theme-size=24
gtk-font-name=Inter 10
gtk-application-prefer-dark-theme=1
GTKEOF

cat > "$HOME/.config/kdeglobals" << KDEEOF
[General]
ColorScheme=RosePineMoon
Name=Rose Pine Moon
widgetStyle=kvantum

[Colors:Window]
BackgroundNormal=35,33,54
ForegroundNormal=224,222,244

[Colors:View]
BackgroundNormal=42,39,62
ForegroundNormal=224,222,244

[Colors:Selection]
BackgroundNormal=196,167,231
ForegroundNormal=35,33,54

[Colors:Button]
BackgroundNormal=57,53,82
ForegroundNormal=224,222,244

[Icons]
Theme=rose-pine-moon-icons

[KDE]
widgetStyle=kvantum
KDEEOF

gsettings set org.gnome.desktop.interface gtk-theme 'rose-pine-moon-gtk' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme 'rose-pine-hyprcursor' 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme 'rose-pine-moon-icons' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true
gsettings set org.gnome.desktop.interface font-name 'Inter 10' 2>/dev/null || true

success "GTK, Qt, and Kvantum configured."
echo ""

# === KVANTUM ACTIVATION ===
info "Activating Kvantum theme..."
if command -v kvantummanager &> /dev/null; then
    kvantummanager --set rose-pine-moon-rose 2>/dev/null || \
        warning "Could not auto-set Kvantum theme — run 'kvantummanager' manually and select rose-pine-moon-rose."
    success "Kvantum theme activated."
else
    warning "kvantummanager not found — install kvantum package."
fi
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

# === WALLPAPERS ===
info "Wallpaper setup..."
mkdir -p "$HOME/Pictures"
if [ -f "$DOTFILES_DIR/assets/rose-pine-desktop.jpg" ]; then
    cp "$DOTFILES_DIR/assets/rose-pine-desktop.jpg" "$HOME/Pictures/rose-pine-desktop.jpg"
    success "Desktop wallpaper copied to ~/Pictures/"
else
    warning "Desktop wallpaper not found in assets/ — copy manually."
fi
if [ -f "$DOTFILES_DIR/assets/rose-pine-lock.jpg" ]; then
    cp "$DOTFILES_DIR/assets/rose-pine-lock.jpg" "$HOME/Pictures/rose-pine-lock.jpg"
    success "Lock screen wallpaper copied to ~/Pictures/"
else
    warning "Lock screen wallpaper not found in assets/ — copy manually."
fi
echo ""

# === DONE ===
echo -e "${ROSE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
success "VELOCITY (Rosé Pine Moon) installed successfully."
echo ""
dim "  Next steps:"
dim "  1. Log out and back in, or reboot"
dim "  2. Select Hyprland from SDDM"
dim "  3. Confirm hyprpaper is pointing to ~/Pictures/rose-pine-desktop.jpg"
dim "  4. Launch alacritty and run: source ~/.zshrc"
dim "  5. Install VS Code extension: code --install-extension mvllow.rose-pine"
dim "  6. If Kvantum didn't auto-apply, run: kvantummanager"
echo ""
echo -e "${ROSE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
