#!/usr/bin/env bash
# macOS dotfiles installer.
# Idempotent. Backs up any existing real file/dir to <path>.bak.<timestamp> before symlinking.

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
PASS_STORE_ICLOUD="$ICLOUD/password-store"
QB_CONFIG="$HOME/.qutebrowser"

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!! \033[0m %s\n' "$*"; }

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -L "$dst" ]]; then
    if [[ "$(readlink "$dst")" == "$src" ]]; then
      log "ok: $dst"
      return
    fi
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    local bak="$dst.bak.$(date +%s)"
    warn "backing up existing $dst -> $bak"
    mv "$dst" "$bak"
  fi
  ln -s "$src" "$dst"
  log "linked: $dst -> $src"
}

# 1. Homebrew packages
if ! command -v brew >/dev/null; then
  warn "Homebrew not found. Install it first: https://brew.sh"
  exit 1
fi

log "Installing pass + gnupg + pinentry-mac via brew"
brew list pass          >/dev/null 2>&1 || brew install pass
brew list gnupg         >/dev/null 2>&1 || brew install gnupg
brew list pinentry-mac  >/dev/null 2>&1 || brew install pinentry-mac

log "Configuring gpg-agent to use pinentry-mac (GUI passphrase prompt)"
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
GPG_AGENT_CONF="$HOME/.gnupg/gpg-agent.conf"
PINENTRY_LINE="pinentry-program /opt/homebrew/bin/pinentry-mac"
if ! grep -qxF "$PINENTRY_LINE" "$GPG_AGENT_CONF" 2>/dev/null; then
  {
    echo "$PINENTRY_LINE"
    echo "default-cache-ttl 3600"
    echo "max-cache-ttl 28800"
  } >> "$GPG_AGENT_CONF"
  chmod 600 "$GPG_AGENT_CONF"
  gpg-connect-agent reloadagent /bye >/dev/null
fi

log "Installing qute-pass python deps (tldextract, idna)"
python3 -m pip install --user --quiet tldextract idna

# 2. Password store on iCloud Drive
if [[ ! -d "$ICLOUD" ]]; then
  warn "iCloud Drive not found at: $ICLOUD"
  warn "Enable iCloud Drive in System Settings, then re-run."
  exit 1
fi
mkdir -p "$PASS_STORE_ICLOUD"
link "$PASS_STORE_ICLOUD" "$HOME/.password-store"

# 3. qutebrowser configs
link "$REPO/qutebrowser/config.py"          "$QB_CONFIG/config.py"
link "$REPO/qutebrowser/quickmarks"         "$QB_CONFIG/quickmarks"
link "$REPO/qutebrowser/bookmarks/urls"     "$QB_CONFIG/bookmarks/urls"
link "$REPO/qutebrowser/userscripts/qute-pass" "$QB_CONFIG/userscripts/qute-pass"

# 4. Next steps for the user (interactive bits we don't automate)
cat <<'EOF'

==> Done. Next steps (interactive — do these yourself):

  1) Generate a GPG key (one-time):
       gpg --full-generate-key
     Pick (9) ECC (default), Curve 25519, no expiration. Identity:
       Parakhat Nuratdinov <nuratdinov.p@gmail.com>

  2) Initialize the password store with that key:
       gpg --list-secret-keys --keyid-format=long
       pass init <YOUR-KEY-ID-OR-EMAIL>

  3) Back up the GPG private key somewhere safe (NOT this repo):
       gpg --export-secret-keys --armor <KEY-ID> > ~/gpg-private-backup.asc
     Then move that file to a secure offline location. If you lose it,
     every password in the store is unrecoverable.

  4) Restart qutebrowser. Test autofill on a login page:
       <Ctrl-J>          fill username + password
       <Ctrl-Shift-J>    fill username only
       <Ctrl-Alt-J>      fill password only

EOF
