-- ===== VELOCITY - Hyprland Config =====
-- User: iswastik3k
-- Theme: Catppuccin Mocha × Hollow Knight
-- Palette: void base, lavender-blue accent, frosted glass surfaces


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

hl.env("GTK_THEME", "catppuccin-mocha-lavender-standard+default")
hl.env("XCURSOR_THEME", "catppuccin-mocha-lavender-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-lavender-cursors")
hl.env("HYPRCURSOR_SIZE", "24")

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

-- Catppuccin Mocha palette (referenced below)
-- base:    #1e1e2e  mantle:  #181825  crust:   #11111b
-- surface0:#313244  surface1:#45475a  surface2:#585b70
-- lavender:#b4befe  mauve:   #cba6f7  blue:    #89b4fa
-- overlay0:#6c7086

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 10,
        border_size = 2,
        col = {
            -- mauve → lavender gradient: echoes the Knight mask glow
            active_border   = { colors = {"0xffcba6f7", "0xffb4befe"}, angle = 45 },
            -- surface0, nearly invisible — lets wallpaper breathe
            inactive_border = "0x40313244",
        },
	resize_on_border = true,
        layout = "dwindle",
    },

    cursor = {
        no_hardware_cursors = false,
    },
    env = {},

    decoration = {
        rounding         = 10,
        active_opacity   = 0.85,
        inactive_opacity = 0.75,   -- dim inactive, frosted effect reads clearly

        blur = {
            enabled           = true,
            size              = 9,      -- frosted glass depth
            passes            = 3,      -- smoothness
            new_optimizations = true,
            vibrancy          = 0.18,   -- slight color bleed, keeps it alive
            vibrancy_darkness = 0.4,
        },

        shadow = {
            enabled      = true,
            range        = 16,
            render_power = 3,
            -- dark mauve shadow: grounded in palette, not harsh black
            color        = "0x66181825",
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


-------------------
---- ANIMATIONS ----
-------------------

-- smooth: slightly springy, fits the floaty butterfly/fog energy
hl.curve("smooth", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("drift",  { type = "bezier", points = { {0.25, 0.1}, {0.25, 1}   } })

hl.animation({ leaf = "windows",    enabled = true, speed = 4,   bezier = "smooth", style = "slide"     })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3.5, bezier = "smooth", style = "slide"     })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3,   bezier = "drift",  style = "slide"     })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 3,   bezier = "smooth"                      })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2.5, bezier = "drift"                       })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4,   bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "layers",     enabled = true, speed = 3,   bezier = "smooth"                      })

---------------------
---- LAYER RULES ----
---------------------
---
hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
})

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
	accel_profile = "adaptive",
        touchpad = {
            natural_scroll = true,
            tap_to_click   = true,
	    drag_lock = true,
	    scroll_factor = 0.95,
        },
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return",     hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Q",          hl.dsp.window.close())
hl.bind(mainMod .. " + R",          hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mainMod .. " + F",          hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V",          hl.dsp.window.float({ action = "toggle" }))

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
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,          hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,  hl.dsp.window.move({ workspace = i }))
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
