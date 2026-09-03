# Changelog — Rosé Pine Moon

All notable changes to this variant are documented here.

---

## [1.0.0] — 2026-08-21

Initial Rosé Pine Moon variant.

### Added

- Hyprland Lua config — Rosé Pine Moon theme, heavier frosted glass
  (0.80 inactive opacity, 12px blur size, 4 passes)
- Softer, more elastic animation curves (glide/settle)
- Alacritty replacing Kitty — no ligature support, accepted tradeoff
- Waybar with restrained, uniform module text (no per-category color)
- Wofi + powermenu with iris selection accent, fixed box-in-box CSS bug
- Dunst with iris-accented normal urgency
- Starship with rose/iris accent-role discipline throughout
- Fastfetch with Rosé Pine color overrides
- Hyprlock with starry-sky lock wallpaper, updated for hyprlock 0.9.6
  config schema (removed deprecated general options, grace moved to
  hypridle's --grace CLI flag)
- Hypridle — dim at 10 min, lock at 15 min, suspend removed (hardware
  resume bug, unresolved)
- Dolphin file manager (KDE-oriented users) with Kvantum
  rose-pine-moon-rose theme, qt6ct, custom kdeglobals
- VS Code — Rosé Pine Moon theme, rose-pine-icons, italics disabled
- System-wide fontconfig — JetBrainsMono Nerd Font Mono (monospace),
  Inter (sans-serif), Noto Serif (serif), Noto Color Emoji (fallback)
- SDDM — lwndhrst/sddm-rose-pine theme, customized colors and blur
- Dual wallpaper strategy — calm painterly piece for desktop,
  dramatic starry-sky piece for lock screen
- install.sh — automated setup including GitHub-sourced Kvantum and
  SDDM theme assets not available via AUR

### Removed

- Zen Browser and associated userChrome.css/userContent.css —
  browser choice now independent, not prescribed by this variant
