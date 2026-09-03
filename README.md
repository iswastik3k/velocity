<div align="center">

# VELOCITY

_A coherent, minimal, keyboard-driven desktop environment_
_built on Arch Linux + Hyprland_

_Not one theme — a system. Every layer of the stack designed
together, then rebuilt in full for each palette._

![WM](https://img.shields.io/badge/wm-Hyprland-e0def4?style=flat-square&labelColor=232136)
![Shell](https://img.shields.io/badge/shell-zsh-e0def4?style=flat-square&labelColor=232136)
![License](https://img.shields.io/badge/license-MIT-e0def4?style=flat-square&labelColor=232136)

</div>

---

## What this is

VELOCITY is a full desktop environment build for Arch Linux +
Hyprland — window manager, bar, launcher, terminal, shell, prompt,
notifications, file manager, editor, lock screen, login screen,
system fonts, cursor, icons — themed as one coherent system rather
than a pile of mismatched configs.

Each variant below is a **complete, independent rebuild** of the
entire stack in a different palette — not a find-and-replace of
colors, but every component reconsidered: accent-role discipline,
animation feel, blur intensity, wallpaper pairing, font choices.
Clone the branch that matches your taste and you get a finished,
working system.

## Variants

| Variant                              | Palette                                             | Branch                                                                                               | Status  |
| ------------------------------------ | --------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------- |
| **Catppuccin Mocha × Hollow Knight** | Void base, lavender-blue accent                     | [`variants/catppuccin-mocha`](https://github.com/iswastik3k/velocity/tree/variants/catppuccin-mocha) | Stable  |
| **Rosé Pine Moon**                   | Dusty base, rose-gold accent, heavier frosted glass | [`variants/rose-pine`](https://github.com/iswastik3k/velocity/tree/variants/rose-pine)               | Stable  |
| Nord                                 | Arctic, cold blue-grey                              | `variants/nord`                                                                                      | Planned |
| Gruvbox                              | Warm, retro, high contrast                          | `variants/gruvbox`                                                                                   | Planned |

Each branch has its own README, CHANGELOG, `packages.txt`, and
`install.sh` — fully self-contained. Nothing on `main` needs to be
combined with a variant branch; pick one and clone it directly.

## Quick start

```bash
git clone https://github.com/iswastik3k/velocity.git
cd velocity
git checkout variants/rose-pine   # or variants/catppuccin-mocha
./install.sh
```

## Philosophy

Minimal chrome. Keyboard-first. Every accent color earns its
place — a system where the palette changes but the discipline
doesn't. Frosted glass, restrained typography, no visual noise
that isn't carrying information.

Full reasoning and component-by-component breakdown lives in each
variant's own README.

## Stack (common across variants)

| Layer          | Role                  |
| -------------- | --------------------- |
| Window Manager | Hyprland (Lua config) |
| Bar            | Waybar                |
| Launcher       | Wofi                  |
| Shell          | Zsh + Zinit           |
| Prompt         | Starship              |
| Notifications  | Dunst                 |
| Lock Screen    | Hyprlock              |
| Idle Daemon    | Hypridle              |
| Login Manager  | SDDM                  |
| System Info    | Fastfetch             |
| Editor         | VS Code               |

Terminal, file manager, cursor, icon theme, and font choices differ
per variant — see each branch for specifics.

## Versioning

Each variant branch is tagged and versioned independently:

[`variants/catppuccin-mocha`](https://github.com/iswastik3k/velocity/tree/variants/catppuccin-mocha)

[`variants/rose-pine`](https://github.com/iswastik3k/velocity/tree/variants/rose-pine)

## License

[MIT](LICENSE) — applies across all branches.

---

<div align="center">
<sub>built by iswastik3k · co-built by claude · Arch Linux · 2026</sub>
</div>
