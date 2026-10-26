# Hyprland translation (for Omarchy)

Omarchy uses **Hyprland**, so `niri/.config/niri/config.kdl` is inert there
unless you also install Niri. This folder ports the keybinds so the muscle
memory carries over.

## Install

```bash
./install.sh --hyprland
```

Then add to `~/.config/hypr/hyprland.conf`:

```ini
source = ~/.config/hypr/niri-binds.conf
```

Source it **after** Omarchy's defaults — later binds win.

## What maps cleanly

| Niri | Hyprland |
|---|---|
| `Mod+Return`, `Mod+Space`, `Mod+B`, … | `exec` binds |
| `Ctrl+H/J/K/L` focus | `movefocus l/d/u/r` |
| `Ctrl+Mod+H/L` move column | `movewindow l/r` |
| `Ctrl+Mod+J/K` move to workspace | `movetoworkspace e+1/e-1` |
| `Mod+Shift+H/J/K/L` focus monitor | `focusmonitor l/d/u/r` |
| `Mod+1…9` / `Mod+Ctrl+1…9` | `workspace` / `movetoworkspace` |
| Volume / brightness keys | `bindel` + `wpctl` / `brightnessctl` |
| Screenshots | `hyprshot` |

## What has no 1:1 equivalent

Hyprland is a dwindle/tiling WM, not a scrolling column WM:

- `consume-or-expel-window-left/right`
- `consume-window-into-column` / `expel-window-from-column`
- `switch-preset-column-width` / `switch-preset-column-width-back`
- `expand-column-to-available-width`
- `center-visible-columns`
- `focus-column-first` / `focus-column-last`
- `move-workspace-down` / `move-workspace-up`
- `Mod+Escape` keyboard-shortcut inhibit

These are left as comments in `niri-binds.conf`. For an actual Niri-like
experience on Omarchy, install Niri (`pacman -S niri`) and use the Niri config
instead.
