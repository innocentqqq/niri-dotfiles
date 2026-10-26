# Keybinds

`Mod` = **Super**. Source of truth: [`niri/.config/niri/config.kdl`](niri/.config/niri/config.kdl) (lines 158–314).

## Apps / launcher

| Key | Action |
|---|---|
| `Mod+Shift+Slash` | Show hotkey overlay |
| `Mod+Return` | Open Ghostty |
| `Mod+Space` | Ignis launcher |
| `Mod+B` | Brave |
| `Mod+E` | Nautilus |
| `Mod+W` | Network settings (Ignis) |
| `Mod+P` | Power menu (Ignis) |
| `Mod+Alt+L` | Lock screen (`niri-locker`) |
| `Mod+O` | Toggle overview |
| `Mod+X`, `Mod+Shift+X` | Close window |

## Vim motions

| Key | Action |
|---|---|
| `Ctrl+H` / `Ctrl+J` / `Ctrl+K` / `Ctrl+L` | Focus column left / window down / window up / column right |
| `Ctrl+Mod+H` / `Ctrl+Mod+L` | Move column left / right |
| `Ctrl+Mod+J` / `Ctrl+Mod+K` | Move window to workspace down / up |
| `Mod+Shift+H/J/K/L` | Focus monitor left/down/up/right |
| `Mod+Shift+Ctrl+H/J/K/L` | Move column to monitor left/down/up/right |

## Columns & sizing

| Key | Action |
|---|---|
| `Mod+Left` / `Mod+Right` | Focus workspace up / down |
| `Mod+Home` / `Mod+End` | Focus first / last column |
| `Mod+Ctrl+Home` / `Mod+Ctrl+End` | Move column to first / last |
| `Mod+BracketLeft` / `Mod+BracketRight` | Consume or expel window left / right |
| `Mod+Comma` / `Mod+Period` | Consume into column / expel from column |
| `Mod+R` / `Mod+Shift+R` | Next / previous preset column width |
| `Mod+Ctrl+Shift+R` | Switch preset window height |
| `Mod+Ctrl+R` | Reset window height |
| `Mod+F` / `Mod+Shift+F` | Maximize column / fullscreen window |
| `Mod+M` | Maximize window to edges |
| `Mod+Ctrl+F` | Expand column to available width |
| `Mod+C` / `Mod+Ctrl+C` | Center column / center visible columns |
| `Mod+Minus` / `Mod+Equal` | Column width −10% / +10% |
| `Mod+Shift+Minus` / `Mod+Shift+Equal` | Window height −10% / +10% |
| `Mod+V` | Toggle floating |
| `Mod+Shift+V` | Switch focus floating ↔ tiling |

## Workspaces

| Key | Action |
|---|---|
| `Mod+Page_Down`, `Mod+U` | Focus workspace down |
| `Mod+Page_Up`, `Mod+I` | Focus workspace up |
| `Mod+Ctrl+Page_Down`, `Mod+Ctrl+U` | Move column to workspace down |
| `Mod+Ctrl+Page_Up`, `Mod+Ctrl+I` | Move column to workspace up |
| `Mod+Shift+Page_Down`, `Mod+Shift+U` | Move workspace down |
| `Mod+Shift+Page_Up`, `Mod+Shift+I` | Move workspace up |
| `Mod+1` … `Mod+9` | Focus workspace 1–9 |
| `Mod+Ctrl+1` … `Mod+Ctrl+9` | Move column to workspace 1–9 |

## Mouse wheel

| Key | Action |
|---|---|
| `Mod+WheelScrollDown/Up` | Focus workspace down / up |
| `Mod+Ctrl+WheelScrollDown/Up` | Move column to workspace down / up |
| `Mod+WheelScrollRight/Left` | Focus column right / left |
| `Mod+Ctrl+WheelScrollRight/Left` | Move column right / left |
| `Mod+Shift+WheelScrollDown/Up` | Focus column right / left |
| `Mod+Ctrl+Shift+WheelScrollDown/Up` | Move column right / left |

## Media / brightness

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` / `LowerVolume` | Volume ±10% (max 100%) |
| `XF86AudioMute` / `XF86AudioMicMute` | Toggle sink / source mute |
| `XF86AudioPlay` / `Stop` / `Prev` / `Next` | Playerctl |
| `XF86MonBrightnessUp` / `Down` | Brightness ±10% |

## Screenshots

| Key | Action |
|---|---|
| `Print` | Screenshot |
| `Ctrl+Print` | Screenshot screen |
| `Alt+Print` | Screenshot window |
| `Ctrl+Shift+S` | Screenshot |

Saves to `~/Pictures/Screenshots/`.

## Session / power

| Key | Action |
|---|---|
| `Mod+Escape` | Toggle keyboard-shortcuts inhibit |
| `Mod+Shift+E` | Quit Niri |
| `Ctrl+Alt+Delete` | Quit Niri |
| `Mod+Shift+P` | Power off monitors |

---

## Ghostty (`ghostty/.config/ghostty/config`)

| Key | Action |
|---|---|
| `Ctrl+Shift+D` | New split right |
| `Ctrl+Shift+S` | New split down |
| `Ctrl+Shift+A` | New split auto |
| `Alt+H/J/K/L` | Go to split left/down/up/right |
| `Alt+E` | Equalize splits |
| `Alt+Z` | Toggle split zoom |
| `Ctrl+Shift+R` | Reload config |

## Hyprland (Omarchy)

See [`hyprland/.config/hypr/niri-binds.conf`](hyprland/.config/hypr/niri-binds.conf).
Most binds map directly; Niri-only column actions are documented as comments.
