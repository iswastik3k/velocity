-- ===== VELOCITY - Hyprland Config =====
-- User: iswastik3k
-- Theme: Rosé Pine Moon (Mocha-like Dark) × Hollow Knight
-- Palette: moon base, iris-rose accent, frosted glass surfaces


--------------------
---- MONITOR ----
--------------------

hl.monitor({
    output   = "",
    mode     = "1920x1080@144",
    position = "auto",
    scale    = 1,
})


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GTK_THEME", "rose-pine-moon-gtk")
hl.env("XCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- Ensure QT apps know to target Kvantum
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hypridle")
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Rosé Pine Moon palette (referenced below)
-- base:    #232136  mantle:  #2a283e  surface: #393552
-- overlay: #6e6a86  text:    #e0def4  subtext: #908caa
-- iris:    #c4a7e7  rose:    #ea9a97  love:    #eb6f92
-- gold:    #f6c177

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 10,
        border_size = 2,

	col = {
            -- rose → iris gradient: primary accent, echoes the wallpaper glow
            active_border   = { colors = {"0xffea9a97", "0xffc4a7e7"}, angle = 45 },
            inactive_border = "0x30393552",
        },

        resize_on_border = true,
        layout = "dwindle",
    },

    cursor = {
        no_hardware_cursors = false,
    },
    env = {},

    decoration = {
        rounding         = 12,
        active_opacity   = 0.85,
        inactive_opacity = 0.75,   -- dim inactive, frosted effect reads clearly

	blur = {
            enabled           = true,
            size              = 12,     -- heavier frost than Mocha's 9
            passes            = 4,      -- smoother falloff
            new_optimizations = true,
            vibrancy          = 0.22,   -- more color bleed, glassier
            vibrancy_darkness = 0.5,
            special           = true,   -- blur special workspaces too
            popups            = true,   -- blur context menus, tooltips
        },

        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            -- dark moon shadow using mantle: grounded in palette, not harsh black
            color        = "0x662a273f",
        },
    },

    animations = {
        enabled = true,
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.window_rule({
    name = "no-shadows-browser",
    match = { class = "^firefox$" },
    no_shadow = true,
})

hl.window_rule({
    name = "dolphin-blur",
    match = { class = "^org%.kde%.dolphin$" },
    opacity = "0.60 override 0.40 override",
})

-------------------
---- ANIMATIONS ----
-------------------

-- smooth: slightly springy, fits the floaty butterfly/fog energy
hl.curve("glide", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("settle", { type = "bezier", points = { {0.22, 0.05}, {0.2, 1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 5,   bezier = "glide",  style = "slide"     })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 4.5, bezier = "glide",  style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "settle", style = "popin 92%" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 4,   bezier = "glide"                        })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 3,   bezier = "settle"                        })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5,   bezier = "glide",  style = "slidevert" })
hl.animation({ leaf = "layers",     enabled = true, speed = 4,   bezier = "glide"                        })

---------------------
---- LAYER RULES ----
---------------------
---
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ 
    match = { namespace = "wofi" }, 
    blur = true, 
})

hl.layer_rule({
    match = { namespace = "hyprlock" },
    animation = "fade 1 2 default",
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        repeat_delay = 145,
        repeat_rate = 45,
        follow_mouse = 1,
        sensitivity  = 1.0,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
            tap_to_click   = true,
            drag_lock = true,
            scroll_factor = 1.35,
        },
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return",     hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Q",          hl.dsp.window.close())
hl.bind(mainMod .. " + R",          hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mainMod .. " + F",          hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V",          hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + B",          hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + C",          hl.dsp.exec_cmd("code"))

-- Focus
hl.bind(mainMod .. " + H",          hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + L",          hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",          hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + J",          hl.dsp.focus({ direction = "down"  }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + SHIFT + L",  hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",  hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down"  }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S",  hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mainMod .. " + SHIFT + F",  hl.dsp.exec_cmd("grimblast copy screen"))

-- Volume
hl.bind("XF86AudioRaiseVolume",     hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",     hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),    { locked = true, repeating = true })
hl.bind("XF86AudioMute",            hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",      hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",    hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Manual Lock trigger
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("~/.local/bin/powermenu.sh"))
