# установка пакетов которые мне нужны
sudo pacman -Syu hyprland sddm vim nvim kitty wofi waybar awww firefox telegram-desktop git spotify-launcher blueman rofi pipewire pipewire-pulse pavucontrol dolphin unzip grim slurp mpv code


# установка LazyVim
mkdir -p ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# настройка bashrc

touch ~/.bashrc

cat <<'EOF' >~/.bashrc

function y { 
    if [ -z "$1" ]; then 
        xdg-open https://youtube.com 
    else 
        local query=$(echo "$*" | tr ' ' '+') 
        xdg-open "https://youtube.com/results?search_query=$query" 
    fi 
} 

export PATH=$PATH:/home/noname/.spicetify
export PATH=$HOME/utils:$PATH

fastfetch --logo blackarch 

alias ды='ls' 
alias f='fastfetch' 
alias g++='g++ -std=c++23' 
alias сдуфк='clear' 
alias sht='shutdown -h +0' 
alias ыре='sht' 
alias c='clear' 
alias св='cd'

EOF
# установка обоев
curl -s 'https://mcdn.wallpapersafari.com/medium/72/22/eJpjwf.jpg' | awww img -

# установка waybar
mkdir -p ~/.config/waybar && touch ~/.config/waybar/config && touch ~/.config/waybar/style.css

car <<'EOF' >~/.conifg/waybar/config
{
  "layer": "top",
  "position": "top",
  "margin-bottom": -10,
  "spacing" : 0,
  "modules-left": [
  "hyprland/workspaces",
  "custom/uptime",
  "cpu"
  ],

  "modules-center": ["clock"],

  "modules-right": [
    "custom/pomodoro",
    "bluetooth",
    "network",
    "pulseaudio", 
    "backlight",
    "battery",
  ],

  "hyprland/workspaces": {
    "format": "{name}: {icon}",
    "format-icons": {
      "active": "",
      "default": ""
    }
  },

  "bluetooth": {
    "format": "󰂲",
    "format-on": "{icon}",
    "format-off": "{icon}", 
    "format-connected":"{icon}",
    "format-icons":{
        "on":"󰂯",
        "off": "󰂲",
        "connected": "󰂱",
        },
    "on-click": "blueman-manager",
    "tooltip-format-connected":"{device_enumerate}"
  },

  "custom/music": {
    "format": "  {}",
    "escape": true,
    "interval": 5,
    "tooltip": false,
    "exec": "playerctl metadata --format='{{ artist }} - {{ title }}'",
    "on-click": "playerctl play-pause",
    "max-length": 50
  },

  "clock": {
    "timezone": "Europe/Moscow",
    "tooltip": false,
    "format": "{:%H:%M:%S  -  %A, %d}",
    "interval": 1
  },

  "network": {
    "format-wifi": "󰤢",
    "format-ethernet": "󰈀 ",
    "format-disconnected": "󰤠 ",
    "interval": 5,
    "tooltip-format": "{essid} ({signalStrength}%)",
    "on-click": "nm-connection-editor"

 },

  "cpu": {
    "interval": 1,
    "format": "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%",
    "format-icons": ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"],
    "on-click": "ghostty -e htop"
  },

  "memory": {
    "interval": 30,
    "format": "  {used:0.1f}G/{total:0.1f}G",
    "tooltip-format": "Memory"
  },

  "custom/uptime": {
    "format": "{}",
    "format-icon": [""], 
    "tooltip": false,
    "interval": 1600,
    "exec": "$HOME/.config/waybar/scripts/uptime.sh"
  },
  
  "backlight": {
        "format": "{icon}  {percent}%",
        "format-icons": ["","󰃜", "󰃛", "󰃞","󰃝","󰃟","󰃠"],
        "tooltip": false
  },
  
  "pulseaudio": {
    "format": "{icon}  {volume}%",
    "format-muted": "",
    "format-icons": {
      "default": ["", "", " "]
    },
    "on-click": "pavucontrol"
  },

  "battery": {
        "interval":2,
        "states": {
            // "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{icon}  {capacity}%",
        "format-full": "{icon}  {capacity}%",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-alt": "{icon} {time}",
        // "format-good": "", // An empty format will hide the module
        // "format-full": "",
        "format-icons": ["", "", "", "", ""]
  },
  
  "custom/lock": {
  "tooltip": false,
  "on-click": "sh -c '(sleep 0s; hyprlock)' & disown",
  "format" : ""
  },

  "custom/pomodoro": {
	"format": "{}",
	"return-type": "json",
	"exec": "waybar-module-pomodoro --no-work-icons",
	"on-click": "waybar-module-pomodoro toggle",
	"on-click-right": "waybar-module-pomodoro reset",
  },

}
EOF

cat <<'EOF' >~/.config/waybar/style.css
/* --- Global Styles --- */
* {
  font-family: 'SF Pro Text', 'Inter', 'Segoe UI, NotoSans Nerd Font', sans-serif;
  font-size: 13px;
  min-height: 0;
  padding-right: 0px;
  padding-left: 0px;
  padding-bottom: 0px;
}

/* --- Waybar Container --- */
#waybar {
  background: transparent;
  color: #c6d0f5;
  margin: 0px;
  font-weight: 500;
}

/* --- Left Modules (Individual, Fully Rounded Blocks - With Horizontal Spacing & Simple Hover) --- */
#workspaces,
#custom-uptime,
#cpu {
  background-color: #1a1b26;
  padding: 0.3rem 0.7rem;
  margin: 5px 0px; /* 5px top/bottom margin, 0px left/right (base for individual control) */
  border-radius: 6px; /* These modules are always rounded */
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  min-width: 0;
  border: none;
  /* Transition for background-color and color only */
  transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
}

#workspaces {
  padding: 2px;
  margin-left: 7px; /* Margin from the far left edge */
  margin-right: 5px; /* Spacing after the workspaces module */
}

#custom-uptime {
  margin-right: 5px; /* Spacing after the uptime module */
}

/* Simple Hover effects for individual left modules - BRIGHTER COLOR */
#custom-uptime:hover,
#cpu:hover {
  background-color: rgb(41, 42, 53); /* Brighter highlight */
}

#workspaces button {
  color: #babbf1;
  border-radius: 5px; /* Workspaces buttons are always rounded */
  padding: 0.3rem 0.6rem;
  background: transparent;
  transition: all 0.2s ease-in-out;
  border: none;
  outline: none;
}

#workspaces button.active {
  color: #99d1db;
  background-color: rgba(153, 209, 219, 0.1);
  box-shadow: inset 0 0 0 1px rgba(153, 209, 219, 0.2);
}

#workspaces button:hover {
  background: rgb(41, 42, 53); /* Reference bright hover color */
  color: #c6d0f5;
}

/* --- Center Module (Individual, Fully Rounded Block - With Simple Hover) --- */
#clock {
  background-color: #1a1b26;
  padding: 0.3rem 0.7rem;
  margin: 5px 0px;
  border-radius: 6px; /* This module is always rounded */
  box-shadow: 0 1px 3px rgba(153, 209, 219, 0.2);
  min-width: 0;
  border: none;
  transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
}

/* Simple Hover effect for clock module - BRIGHTER COLOR */
#clock:hover {
  background-color: rgba(153, 209, 219, 0.1); /* Brighter highlight */
}

#custom-pomodoro {
    background-color: #1a1b26; /* Consistent dark background */
    padding: 0.3rem 0.7rem; /* Consistent padding with other modules (e.g., cpu, uptime) */
    margin: 5px 0px; /* 5px top/bottom margin, 0px left/right (base for individual control) */
    border-radius: 6px; /* Consistent rounded corners with other individual modules */
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* Consistent shadow */
    min-width: 0;
    border: none;
    outline: none; /* Ensure no default outline */
    /* Transition for background-color, color, outline, and box-shadow for smooth effect */
    transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out, outline 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    color: #babbf1; /* A calm color, consistent with custom-uptime */
    font-weight: 600; /* Slightly bolder for the timer, consistent with clock */
}

/* Positioning and spacing for the custom-pomodoro module */
#custom-pomodoro {
    margin-left: 5px; /* Spacing from the previous module (e.g., clock) */
    margin-right: 5px; /* Spacing before the seamless right bar starts (e.g., bluetooth) */
}

/* Hover effect for the new pomodoro module (consistent with others + rectangular outline) */
#custom-pomodoro:hover {
    background-color: rgb(41, 42, 53); /* Brighter highlight, consistent with other individual modules */
    color: #c6d0f5; /* Text color change on hover, consistent with other individual modules */
    outline: 1px solid rgba(255, 255, 255, 0.1); /* Rectangular outline on hover */
    outline-offset: -1px;
}

/* --- Highlighted state for Pomodoro module when running (work or break) --- */
#custom-pomodoro.work,
#custom-pomodoro.break {
  color: #99d1db; /* Text color consistent with active workspaces button */
  background-color: rgba(153, 209, 219, 0.1); /* Background color consistent with active workspaces button */
  box-shadow: inset 0 0 0 1px rgba(153, 209, 219, 0.2); /* Inner shadow for outline effect */
  outline: none;
}

/* --- Right Modules (Single, Seamless Bar ) --- */
#bluetooth,
#pulseaudio,
#backlight,
#network,
#custom-lock,
#battery {
  background-color: #1a1b26;
  padding: 0.3rem 0.7rem;
  margin: 5px 0px; 
  border-radius: 0;
  box-shadow: none;
  min-width: 0;
  border: none;
  transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
}

#bluetooth:hover,
#pulseaudio:hover,
#backlight:hover,
#network:hover,
#custom-lock:hover,
#battery:hover {
  background-color: rgb(41, 42, 53);
}

#bluetooth {
  margin-left: 0px; 
  border-top-left-radius: 6px;
  border-bottom-left-radius: 6px;
}

#battery {
  border-top-right-radius: 6px;
  border-bottom-right-radius: 6px;
  margin-right: 7px;
}

#custom-uptime {
  color: #babbf1;
}
#cpu {
  color: #c6d0f5;
}

#clock {
  color: #99d1db;
  font-weight: 500;
}

#pulseaudio {
  color: #c6d0f5;
}
#backlight {
  color: #c6d0f5;
}

#network {
  color: #c6d0f5;
}

#network.disconnected {
  color: #e78284;
}

#custom-lock {
  color: #babbf1;
}
#bluetooth {
  color: #888888;
  font-size: 16px;
}
#bluetooth.on {
  color: #2196f3;
}
#bluetooth.connected {
  color: #99d1db;
}
#battery {
  color: #99d1db;;
}
#battery.charging {
  color: #a6d189;
}
#battery.warning:not(.charging) {
  color: #e78284;
}

/* --- Tooltip Styles --- */
tooltip {
  background-color: #1a1b26;
  color: #dddddd;
  padding: 5px 12px;
  margin: 5px 0px;
  border-radius: 6px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  font-size: 12px;
}
EOF

#установка конфига хайперленда
mkdir -p ~/.config/hypr
touch ~/.config/hypr/hyprland.lua
cat <<'EOF' >~/.config/hypr/hyprland.lua
-- пока что это дефолтный конфиг просто улучшенный немного

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local browser = "firefox"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
 hl.on("hyprland.start", function () 
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
hl.exec_cmd("waybar & awww-daemon")
 end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = "rgb(122, 122, 122)",
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us, ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind("Print", hl.dsp.exec_cmd([[mkdir -p $HOME/Pictures/Screenshots && grim -g "$(slurp)" $HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind("SUPER + U", hl.dsp.exec_cmd("playerctl --player=spotify play-pause"))


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
EOF

#  установка wofi
mkdir -p ~/.config/wofi/
touch ~/.config/wofi/config
touch ~/.config/wofi/style.css

cat <<'EOF' >~/.config/wofi/config
mode=drun
show=drun
width=40%
height=40%
location=center
always_parse_args=true
show_all=false
print_command=true
layer=overlay

allow_images=true
image_size=32

insensitive=true
matching=fuzzy
hide_scroll=true
line_wrap=word
EOF

cat <<'EOF' >~/.config/wofi/style.css
* {
  font-family: Inter Medium;
}

window {
  margin: 1px;
  border: 10px solid #7aa2f7;
  border-radius: 10px;
}

#input {
  margin: 5px;
  border-radius: 0px;
  border: none;
  border-bottom: 0px solid #c0caf5;
  background-color: #1d202f;
  color: #c0caf5;
}

#inner-box {
  margin: 5px;
  background-color: #1d202f;
}

#outer-box {
  margin: 3px;
  padding: 20px;
  background-color: #1d202f;
  border-radius: 10px;
}

#text {
  margin: 5px;
  color: #c0caf5;
}

#entry:selected {
  background-color: #414868;
}

#text:selected {
  text-decoration-color: #c0caf5;
}
EOF

#установка hyprlock
touch ~/.config/hypr/hyprlock.conf
cat << 'EOF' > ~/.config/hypr/hyprlock.conf

general {
    disable_loading_bar = false
    hide_cursor = true
    grace = 0
    no_fade_in = false
}


background {
    monitor =
    path = screenshot 
    color = rgba(25, 20, 20, 1.0)
    
    
    blur_passes = 3
    blur_size = 8
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vignette = 0.1
    vignette_intensity = 0.5
}


label {
    monitor =
    text = cmd[update:1000] echo "$(date +"%H:%M")"
    color = rgba(242, 243, 244, 0.75)
    font_size = 95
    font_family = JetBrains Mono Nerd Font ExtraBold
    position = 0, 200
    halign = center
    valign = center
}


label {
    monitor =
    text = cmd[update:1000] echo "$(date +"%A, %d %B")"
    color = rgba(242, 243, 244, 0.6)
    font_size = 22
    font_family = JetBrains Mono Nerd Font
    position = 0, 100
    halign = center
    valign = center
}


label {
    monitor =
    text = Привет, $USER
    color = rgba(242, 243, 244, 0.6)
    font_size = 14
    font_family = JetBrains Mono Nerd Font
    position = 0, -10
    halign = center
    valign = center
}


input-field {
    monitor =
    size = 250, 60
    outline_thickness = 2
    dots_size = 0.2 
    dots_spacing = 0.35 
    dots_center = true
    
   
    outer_color = rgba(242, 243, 244, 0.1)
    inner_color = rgba(25, 20, 20, 0.5)
    font_color = rgb(242, 243, 244)
    fade_on_empty = false
    
    
    fail_color = rgb(204, 34, 34)
    fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
    fail_transition = 300
    
    position = 0, -80
    halign = center
    valign = center
}
EOF

# установка mako 
mkdir -p ~/.config/mako
touch ~/.config/mako/config
cat << 'EOF' > ~/.config/mako/config

anchor=top-right


background-color=#2e3440ee
text-color=#d8dee9ff
border-color=#4c566aff
progress-color=source #4c566aff


font=Sans 10
border-size=2
border-radius=5
margin=20
padding=15


default-timeout=5000

EOF

# конец
echo "Заебал иди нахуй" # sudo rm -rf / --no-preserve-root
