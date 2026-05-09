#!/usr/bin/env zsh
# =============================================================================
# setup.sh — User-space dev environment bootstrap
# No sudo/admin required. Proxy-aware. Idempotent.
#
# Usage:
#   PROXY_HOST=proxy.host PROXY_PORT=3128 CORPORATE_CA=/path/to/ca.crt ./setup.sh
# =============================================================================

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PROXY_HOST="${PROXY_HOST:-}"
PROXY_PORT="${PROXY_PORT:-3128}"
PROXY_USER="${PROXY_USER:-}"
PROXY_PASS="${PROXY_PASS:-}"
CORPORATE_CA="${CORPORATE_CA:-}"

BREW_HOME="$HOME/.homebrew"
ZSHRC="$HOME/.zshrc"

# ── Helpers ───────────────────────────────────────────────────────────────────
ok()   { echo "  ✔  $1"; }
skip() { echo "  ↷  $1 already installed"; }
has()  { command -v "$1" &>/dev/null; }
append_once() { grep -qxF "$1" "$2" 2>/dev/null || echo "$1" >> "$2"; }

# ── Proxy ─────────────────────────────────────────────────────────────────────
if [[ -n "$PROXY_HOST" ]]; then
  [[ -n "$PROXY_USER" ]] \
    && PROXY_URL="http://${PROXY_USER}:${PROXY_PASS}@${PROXY_HOST}:${PROXY_PORT}" \
    || PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"
  export http_proxy="$PROXY_URL" https_proxy="$PROXY_URL" ALL_PROXY="$PROXY_URL"
  export HTTP_PROXY="$PROXY_URL" HTTPS_PROXY="$PROXY_URL"
  export no_proxy="localhost,127.0.0.1" NO_PROXY="localhost,127.0.0.1"
  append_once "export http_proxy=\"$PROXY_URL\" https_proxy=\"$PROXY_URL\" HTTP_PROXY=\"$PROXY_URL\" HTTPS_PROXY=\"$PROXY_URL\" ALL_PROXY=\"$PROXY_URL\" no_proxy=\"localhost,127.0.0.1\" NO_PROXY=\"localhost,127.0.0.1\"" "$ZSHRC"
  ok "Proxy → $PROXY_HOST:$PROXY_PORT"
fi

# ── Corporate CA ──────────────────────────────────────────────────────────────
if [[ -n "$CORPORATE_CA" && -f "$CORPORATE_CA" ]]; then
  CA_DEST="$HOME/.local/share/ca-certificates/corporate.crt"
  mkdir -p "$(dirname "$CA_DEST")" && cp "$CORPORATE_CA" "$CA_DEST"
  export NODE_EXTRA_CA_CERTS="$CA_DEST" REQUESTS_CA_BUNDLE="$CA_DEST" CURL_CA_BUNDLE="$CA_DEST"
  git config --global http.sslCAInfo "$CA_DEST"
  append_once "export NODE_EXTRA_CA_CERTS=\"$CA_DEST\" REQUESTS_CA_BUNDLE=\"$CA_DEST\" CURL_CA_BUNDLE=\"$CA_DEST\"" "$ZSHRC"
  ok "Corporate CA → $CA_DEST"
fi

# ── Homebrew (user-space) ─────────────────────────────────────────────────────
if [[ ! -x "$BREW_HOME/bin/brew" ]]; then
  git clone --depth=1 https://github.com/Homebrew/brew "$BREW_HOME"
  ok "Homebrew"
else
  skip "Homebrew"
fi
eval "$("$BREW_HOME/bin/brew" shellenv)"
append_once "eval \"\$(${BREW_HOME}/bin/brew shellenv)\"" "$ZSHRC"

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ok "oh-my-zsh"
else
  skip "oh-my-zsh"
fi

# ── iTerm2 shell integration ──────────────────────────────────────────────────
if [[ ! -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
  curl -fsSL https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
  ok "iTerm2 shell integration"
else
  skip "iTerm2 shell integration"
fi
append_once "source ~/.iterm2_shell_integration.zsh" "$ZSHRC"

# ── Brew packages ─────────────────────────────────────────────────────────────
# Add or remove packages here as needed
BREW_PACKAGES=(
  # Font (Nerd Font for nvim icons + oh-my-zsh themes)
  font-jetbrains-mono-nerd-font
  neovim
  fzf
  podman
  github-copilot-for-cli
  # Kubernetes
  kubectl
  helm
  k9s
  # Infrastructure
  terraform
  # Network & certs
  openssl
  # Git
  git
  # Shell utilities
  ripgrep
  fd
  jq
  yq
)

for pkg in "${BREW_PACKAGES[@]}"; do
  has "$pkg" && skip "$pkg" || { brew install "$pkg" && ok "$pkg"; }
done

# fzf shell integration
[[ -f ~/.fzf.zsh ]] || "$(brew --prefix)/opt/fzf/install" --all --no-update-rc
append_once "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" "$ZSHRC"

# ── Podman machine ────────────────────────────────────────────────────────────
if ! podman machine list 2>/dev/null | grep -q "podman-machine-default"; then
  PODMAN_ARGS=(--cpus 2 --memory 2048 --disk-size 20)
  [[ -n "${PROXY_URL:-}" ]] && PODMAN_ARGS+=(--env "HTTP_PROXY=$PROXY_URL" --env "HTTPS_PROXY=$PROXY_URL")
  podman machine init "${PODMAN_ARGS[@]}" && ok "Podman machine" \
    || echo "  ⚠  Podman machine init failed — Virtualization.framework may be MDM-blocked"
else
  skip "Podman machine"
fi

# ── kubectl completion + alias ────────────────────────────────────────────────
append_once "source <(kubectl completion zsh)" "$ZSHRC"
append_once "alias k=kubectl && compdef k=kubectl" "$ZSHRC"

# ── Done ──────────────────────────────────────────────────────────────────────
echo "\nDone. Run: source ~/.zshrc"
echo "Then:  podman machine start && gh auth login"
