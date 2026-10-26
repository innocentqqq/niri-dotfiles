# niri-dotfiles

My **Niri** desktop setup on Arch Linux — window manager, keybinds, terminal,
editor, and the helper scripts that glue it together. Clone it on a fresh
Arch/Omarchy install and run one script to get the same environment back.

> **Omarchy note:** Omarchy ships **Hyprland**, not Niri. The Niri config is
> still installable (`pacman -S niri`), and `hyprland/` contains a translated
> keybind fragment if you want the same muscle memory on Omarchy's default WM.

## What's inside

```
niri-dotfiles/
├── niri/                     # Niri WM
│   ├── .config/niri/
│   │   ├── config.kdl        # ACTIVE config (the only file Niri reads)
│   │   ├── colors.kdl        # color fragment (reference)
│   │   ├── basicsettings.kdl # niri-settings fragment (reference)
│   │   └── keybinds.kdl      # empty, managed by niri-settings
│   ├── backups/              # older config snapshots
│   └── matugen/niri.kdl      # matugen color template
├── ghostty/                  # Ghostty + shaders
├── kitty/                    # Kitty terminal
├── nvim/                     # Neovim (based on jdhao/nvim-config)
├── zsh/                      # .zshrc + secrets template
├── bin/                      # niri-locker, idle-manager, powermenu, …
├── hyprland/                 # Omarchy/Hyprland keybind translation
├── install.sh
├── KEYBINDS.md               # full keybind reference
└── README.md
```

## Install

```bash
git clone https://github.com/innocentqqq/niri-dotfiles.git
cd niri-dotfiles
./install.sh --dry-run     # preview
./install.sh               # copy into ~/.config (recommended)
```

Options:

| Flag | Effect |
|---|---|
| `--copy` | Copy files (default). Rewrites hard-coded `/home/god` paths to `$HOME`. |
| `--link` | Symlink instead of copy. Same machine only — hard-coded paths assume `/home/god`. |
| `--hyprland` | Also install `~/.config/hypr/niri-binds.conf`. |
| `--dry-run` | Print actions without changing anything. |

Existing files are backed up to `~/.dotfiles-backup-<timestamp>/` before being
replaced. An existing `~/.zshrc` is **never** overwritten.

Then:

```bash
niri validate
# log out and choose Niri in your display manager, or:
niri-session
```

## Dependencies

Install what you need (Arch / Omarchy):

```bash
sudo pacman -S --needed niri ghostty kitty neovim zsh \
  swayidle swaylock playerctl brightnessctl wl-clipboard \
  grim slurp jq libnotify
```

Used by the config but optional:

| Tool | Used for |
|---|---|
| `ignis` | launcher / power menu / network settings |
| `awww-daemon` | wallpapers |
| `brave`, `nautilus` | app binds |
| `brightnessctl` | brightness keys |
| `playerctl` | media keys / idle inhibit |
| `hyprshot` | Omarchy screenshots (Hyprland fragment) |
| `hyprexpo` (Hyprland plugin) | `Mod+O` overview equivalent |

## Keybinds

`Mod` = **Super**. Full tables: **[KEYBINDS.md](KEYBINDS.md)**.

Highlights:

| Keys | Action |
|---|---|
| `Ctrl+H/J/K/L` | Focus left/down/up/right (vim motions) |
| `Ctrl+Mod+H/L` | Move column left/right |
| `Ctrl+Mod+J/K` | Move window to workspace down/up |
| `Mod+Shift+H/J/K/L` | Focus monitor |
| `Mod+Shift+Ctrl+H/J/K/L` | Move column to monitor |
| `Mod+F` / `Mod+Shift+F` | Maximize column / fullscreen |
| `Mod+V` | Toggle floating |
| `Mod+1…9` | Focus workspace |
| `Mod+Ctrl+1…9` | Move column to workspace |
| `Mod+O` | Overview |
| `Mod+Return` | Ghostty |
| `Mod+Space` | Launcher |

## Secrets

The repo contains **no tokens**. `zsh/.zshrc` sources an optional
`~/.config/secrets.zsh`:

```bash
cp zsh/secrets.example.zsh ~/.config/secrets.zsh
chmod 600 ~/.config/secrets.zsh
$EDITOR ~/.config/secrets.zsh
```

`~/.config/secrets.zsh` is git-ignored.

## Omarchy / Hyprland

```bash
./install.sh --hyprland
# then, in ~/.config/hypr/hyprland.conf:
source = ~/.config/hypr/niri-binds.conf
```

See [`hyprland/README.md`](hyprland/README.md) for what maps cleanly and what
has no Hyprland equivalent.

## Notes

- Only `niri/.config/niri/config.kdl` is read by Niri. The other `.kdl` files
  are kept as fragments/reference because Niri 26.04 has no `include` directive.
- `niri/matugen/niri.kdl` is a template; wire it up if you use matugen.
- NVIDIA / 32-bit / portal setup is intentionally left out — this repo is just
  the user config.

## For OpenCode / AI agents

Project instructions live in [`AGENTS.md`](AGENTS.md). Key rules for automation:

- Run `./install.sh --dry-run` before any real install.
- Never commit secrets; `zsh/.zshrc` only sources `~/.config/secrets.zsh`.
- Only `niri/.config/niri/config.kdl` is read by Niri.

## License

MIT — see [`LICENSE`](LICENSE). Third-party/vendored components retain their
upstream licenses (see the Credits section).

## Credits

- Neovim config based on [jdhao/nvim-config](https://github.com/jdhao/nvim-config)
- Ghostty shaders from [hackr-sh/ghostty-shaders](https://github.com/hackr-sh/ghostty-shaders)
- Screensaver companion: [jfreed-dev/niri-screensaver](https://github.com/jfreed-dev/niri-screensaver)
- Terminal effects: [ChrisBuilds/terminaltexteffects](https://github.com/ChrisBuilds/terminaltexteffects)
