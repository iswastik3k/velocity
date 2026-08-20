<div align="center">

# VELOCITY

_A coherent, minimal, keyboard-driven desktop environment_
_built on Arch Linux + Hyprland_

![Theme](https://img.shields.io/badge/theme-Catppuccin%20Mocha-b4befe?style=flat-square&labelColor=1e1e2e)
![WM](https://img.shields.io/badge/wm-Hyprland-cba6f7?style=flat-square&labelColor=1e1e2e)
![Shell](https://img.shields.io/badge/shell-zsh-b4befe?style=flat-square&labelColor=1e1e2e)
![License](https://img.shields.io/badge/license-MIT-a6e3a1?style=flat-square&labelColor=1e1e2e)

</div>

---

![preview](assets/preview0.png)

<br>

![preview](assets/preview1.png)

## Philosophy

Void base. Lavender-blue accent. Frosted glass surfaces.
Every layer of the stack themed to a single coherent vision —
Catppuccin Mocha palette rendered through the aesthetic of Hollow Knight.
Minimal chrome, maximum focus, keyboard-first workflow.

## Stack

| Component      | Tool                      |
| -------------- | ------------------------- |
| Window Manager | Hyprland (Lua config)     |
| Bar            | Waybar                    |
| Launcher       | Wofi                      |
| Terminal       | Kitty                     |
| Shell          | Zsh + Zinit               |
| Prompt         | Starship                  |
| Notifications  | Dunst                     |
| File Manager   | Yazi                      |
| Browser        | Zen Browser               |
| Editor         | VS Code                   |
| Lock Screen    | Hyprlock                  |
| Idle Daemon    | Hypridle                  |
| Login Manager  | SDDM                      |
| System Info    | Fastfetch                 |
| GTK Theme      | Catppuccin Mocha Lavender |
| Cursor         | Catppuccin Mocha Lavender |
| Icons          | Papirus Dark              |
| Font           | JetBrainsMono Nerd Font   |
| Wallpaper      | Hollow Knight fanart      |

## Dependencies

All packages are listed in `packages.txt`.

```bash
yay -S --needed - < packages.txt
```

## Installation

> Built for Arch Linux. Tested on Hyprland 0.56+ with Lua config enabled.

```bash
git clone https://github.com/iswastik3k/velocity.git
cd velocity
./install.sh
```

The installer will:

- Install all packages from `packages.txt`
- Symlink all dotfiles to their correct locations
- Back up any existing configs before overwriting
- Configure SDDM, GTK theme, cursors, and shell
- Install Zinit and Yazi plugins

## After Installation

Some things require manual attention:

1. **Wallpaper** — copy `assets/hollow-knight.jpg` to `~/Pictures/hollow-knight.jpg`
2. **VS Code** — install extensions and apply Catppuccin Mocha theme manually
3. **Zen Browser** — apply `userChrome.css` and `userContent.css` from `assets/zen/`

## Variants

| Branch               | Palette                   | Status  |
| -------------------- | ------------------------- | ------- |
| `main`               | Catppuccin Mocha Lavender | Stable  |
| `variants/rose-pine` | Rosé Pine                 | Planned |
| `variants/nord`      | Nord                      | Planned |
| `variants/gruvbox`   | Gruvbox                   | Planned |

## Versioning

Follows semantic versioning.

- `v1.x.x` — Catppuccin Mocha Lavender, current aesthetic
- `v2.x.x` — Reserved for full rework or new base theme

See [CHANGELOG.md](CHANGELOG.md) for release history.

## License

MIT.

---

<div align="center">
<sub>built by iswastik3k · Arch Linux · 2026</sub>
</div>
