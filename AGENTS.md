# AGENTS.md — instructions for OpenCode

This repository is a **dotfiles repo** for a Niri (Arch Linux) desktop. It is
not an application: "running" it means deploying config files into `$HOME` and
validating them. Follow these rules when editing or executing anything here.

## Golden rules

1. **Never commit secrets.** `zsh/.zshrc` must only `source` an untracked
   `~/.config/secrets.zsh`. Before every commit, run the secret scan below.
2. **Only `niri/.config/niri/config.kdl` is read by Niri.** Niri 26.04 has no
   `include` directive. `colors.kdl`, `basicsettings.kdl`, and `keybinds.kdl`
   are fragments/reference only — do not claim they are loaded.
3. **`install.sh` is destructive to `~/.config`.** Always run
   `./install.sh --dry-run` first. Never run the real install in a test or CI
   context. It backs up existing targets to `~/.dotfiles-backup-<timestamp>/`.
4. **Do not overwrite a user's live config** (`~/.config/niri`, `~/.zshrc`,
   `~/.config/nvim`) unless the user explicitly asks. When updating this repo
   from a live machine, copy *into* the repo, never the reverse.
5. **Portability:** source configs may contain `/home/god/...`. `install.sh`
   rewrites that to `$HOME` on copy. Keep new absolute paths in the same form so
   the rewrite keeps working.
6. **Two WM dialects:** `niri/` is KDL, `hyprland/` is Hyprland INI. Never mix
   syntax between them. Omarchy ships Hyprland, not Niri.

## Layout

```text
niri/.config/niri/        # Niri config (config.kdl is active)
niri/backups/             # historical snapshots (not loaded)
niri/matugen/niri.kdl     # matugen template
ghostty/.config/ghostty/  # Ghostty + shaders
kitty/.config/kitty/      # Kitty
nvim/.config/nvim/        # Neovim (based on jdhao/nvim-config)
zsh/.zshrc                # sanitized shell config
zsh/secrets.example.zsh   # template -> ~/.config/secrets.zsh
bin/                      # helper scripts -> ~/.local/bin
hyprland/.config/hypr/    # Niri -> Hyprland keybind translation
install.sh                # deploy script
KEYBINDS.md               # authoritative keybind reference
```

## Verification commands

Run these before committing:

```bash
bash -n install.sh
./install.sh --dry-run

# Secret scan (must print nothing)
grep -rniE "sk-or-v1-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|xox[baprs]-|AKIA[0-9A-Z]{16}" .

git status --short
```

If `niri` is installed, also validate the WM config:

```bash
niri validate
```

For the Hyprland fragment, a syntax check requires Hyprland:

```bash
Hyprland --verify-config   # only if Hyprland is installed
```

## Updating configs from the live system

```bash
cp ~/.config/niri/config.kdl   niri/.config/niri/config.kdl
cp ~/.config/ghostty/config    ghostty/.config/ghostty/config
cp ~/.config/kitty/{kitty.conf,colors.conf} kitty/.config/kitty/
cp ~/.local/bin/niri-*         bin/

# zsh: sanitize before committing!
cp ~/.zshrc zsh/.zshrc
```

Then replace any real token in `zsh/.zshrc` with the `secrets.zsh` source block
and re-run the secret scan.

## Editing conventions

- **Niri (KDL):** `binds { Mod+Key { action; } }`, `Mod` = Super. Keep binds
  grouped and commented like the existing file.
- **Hyprland (INI):** `bind = MODS, key, dispatcher, params`. Source order
  matters; `niri-binds.conf` is meant to be sourced after Omarchy defaults.
- **Shell:** `install.sh` uses `set -euo pipefail`; keep it POSIX-friendly
  where practical and quote paths.
- **Docs:** update `KEYBINDS.md` whenever a bind changes, and `README.md` when
  the layout or install flow changes.

## License

The repository is MIT (see `LICENSE`). Vendored/derived material keeps its
upstream license:

- Neovim config: `jdhao/nvim-config` (see `nvim/.config/nvim/LICENSE`)
- Ghostty shaders: `hackr-sh/ghostty-shaders`
- Screensaver/effects references: `jfreed-dev/niri-screensaver`,
  `ChrisBuilds/terminaltexteffects`
