#!/usr/bin/env bash
# install.sh — deploy this repo's configs into $HOME.
#
# Usage:
#   ./install.sh                # copy files (portable, rewrites /home/god -> $HOME)
#   ./install.sh --link         # symlink files instead of copying (same machine only)
#   ./install.sh --copy         # explicit copy mode (default)
#   ./install.sh --hyprland     # also install the Hyprland bind fragment
#   ./install.sh --dry-run      # show what would happen
#
# Every existing target is backed up to ~/.dotfiles-backup-<timestamp>/ first.

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODE="copy"
INSTALL_HYPRLAND=0
DRY_RUN=0
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

log()  { printf '\033[1;36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31m[x]\033[0m %s\n' "$*" >&2; exit 1; }

usage() {
  sed -n '2,15p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --link)     MODE="link" ;;
    --copy)     MODE="copy" ;;
    --hyprland) INSTALL_HYPRLAND=1 ;;
    --dry-run)  DRY_RUN=1 ;;
    -h|--help)  usage; exit 0 ;;
    *) die "Unknown option: $1 (try --help)" ;;
  esac
  shift
done

run() {
  if (( DRY_RUN )); then
    printf '    [dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

backup_target() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    local bdir="$BACKUP$(dirname "$target")"
    run mkdir -p "$bdir"
    run cp -a "$target" "$bdir/"
    warn "backed up $target -> $bdir/"
    run rm -rf "$target"
  fi
}

# install_path <src> <dest>
install_path() {
  local src="$1" dest="$2"
  run mkdir -p "$(dirname "$dest")"
  backup_target "$dest"
  if [[ "$MODE" == "link" ]]; then
    run ln -s "$src" "$dest"
  else
    run cp -a "$src" "$dest"
    # Make copied configs portable across usernames.
    if (( ! DRY_RUN )) && [[ -f "$dest" || -d "$dest" ]]; then
      grep -rlI --exclude-dir=.git '/home/god' "$dest" 2>/dev/null | while read -r f; do
        run sed -i "s|/home/god|$HOME|g" "$f"
      done
    fi
  fi
  log "installed $dest ($MODE)"
}

require() {
  command -v "$1" >/dev/null 2>&1 || warn "missing dependency: $1"
}

log "Repo: $REPO_DIR"
log "Mode: $MODE"

# --- core configs -----------------------------------------------------------
install_path "$REPO_DIR/niri/.config/niri"           "$HOME/.config/niri"
install_path "$REPO_DIR/ghostty/.config/ghostty"     "$HOME/.config/ghostty"
install_path "$REPO_DIR/kitty/.config/kitty"         "$HOME/.config/kitty"
install_path "$REPO_DIR/nvim/.config/nvim"           "$HOME/.config/nvim"

# --- helper scripts ---------------------------------------------------------
log "Installing helper scripts into ~/.local/bin"
run mkdir -p "$HOME/.local/bin"
for f in "$REPO_DIR"/bin/*; do
  [[ -f "$f" ]] || continue
  dest="$HOME/.local/bin/$(basename "$f")"
  backup_target "$dest"
  run cp "$f" "$dest"
  run chmod +x "$dest"
  if (( ! DRY_RUN )); then
    sed -i "s|/home/god|$HOME|g" "$dest"
  fi
  log "installed $dest"
done

# --- zsh --------------------------------------------------------------------
# Never silently clobber an existing ~/.zshrc.
if [[ -e "$HOME/.zshrc" ]]; then
  warn "~/.zshrc already exists — left untouched."
  warn "Compare it with $REPO_DIR/zsh/.zshrc, or re-run after moving it aside."
else
  install_path "$REPO_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

if [[ ! -e "$HOME/.config/secrets.zsh" ]]; then
  warn "No ~/.config/secrets.zsh found."
  warn "Create it from zsh/secrets.example.zsh and chmod 600."
fi

# --- optional Hyprland fragment --------------------------------------------
if (( INSTALL_HYPRLAND )); then
  install_path "$REPO_DIR/hyprland/.config/hypr/niri-binds.conf" \
               "$HOME/.config/hypr/niri-binds.conf"
  warn "Add this line to ~/.config/hypr/hyprland.conf:"
  warn "    source = ~/.config/hypr/niri-binds.conf"
fi

# --- dependency hints -------------------------------------------------------
log "Checking common dependencies (warnings only)"
for bin in niri ghostty kitty nvim zsh swayidle swaylock playerctl brightnessctl wpctl; do
  require "$bin"
done

cat <<EOF

Done.

Backups (if any): $BACKUP

Next steps:
  1. Log out and pick "Niri" in your display manager (or run: niri-session).
  2. Validate the config:  niri validate
  3. Add your API token:   cp "$REPO_DIR/zsh/secrets.example.zsh" ~/.config/secrets.zsh
                           chmod 600 ~/.config/secrets.zsh
  4. On Omarchy (Hyprland): ./install.sh --hyprland
     then add:  source = ~/.config/hypr/niri-binds.conf
EOF
