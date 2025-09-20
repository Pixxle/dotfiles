# shellcheck shell=bash

_query_setup() {
  # Call this function with _query_setup("aws")
  ALL_PKG_INSTALLED=true
  for pkg in "$@"; do
    if ! command -v "$pkg" >/dev/null; then
      ALL_PKG_INSTALLED=false
    fi
  done
  if [ "$ALL_PKG_INSTALLED" = "true" ]; then return 0; fi

  echo "We've noticed one or more missing dependencies required to run the called command"
  echo "Would you like to install commonly used tools?[y/n] "
  while true; do
    read -r yn # I'm using simple read instead of inline read -p since that is flaky in zsh since a few years back
    case $yn in
    [Yy]*)
      install-common-tools
      return 0
      ;;
    [Nn]*) return 2 ;;
    *) echo "Please answer [y]es or [n]o." ;;
    esac
  done
}

# Install common development tools via Homebrew
install-common-tools() {
  local -a packages=(
    "jq"
    "python"
    "rust"
    "git"
    "fzf"
    "fd"
    "neovim"
    "zsh"
    "ripgrep"
    "bat"
    "eza"
    "htop"
    "iterm2"
    "kubectl"
    "nvm"
    "npm"
    "zoxide"
    "tokei"
    "erdtree"
    "docker"
    "docker-compose"
    "eslint"
    "prettier"
    "jj"
  )

  local -a taps=(
    "hashicorp/tap/terraform"
    "derailed/k9s/k9s"
    "FelixKratz/formulae/borders"
  )

  local -a casks=(
    "homebrew/cask-fonts"
    "nikitabobko/tap/aerospace"
  )

  _install_packages "${packages[@]}"
  _install_taps "${taps[@]}"
  _install_casks "${casks[@]}"
  _copy_aerospace_config
}

# Install regular packages
_install_packages() {
  local packages=("$@")
  for pkg in "${packages[@]}"; do
    if ! command -v "$pkg" >/dev/null 2>&1; then
      echo "Installing $pkg..."
      brew install "$pkg" || echo "Failed to install $pkg"
    else
      echo "$pkg already installed"
    fi
  done
}

# Install tap packages
_install_taps() {
  local taps=("$@")
  for tap_pkg in "${taps[@]}"; do
    local pkg_name=$(basename "$tap_pkg")
    local tap_name=$(dirname "$tap_pkg")

    if ! command -v "$pkg_name" >/dev/null 2>&1; then
      echo "Installing $pkg_name from $tap_name..."
      brew tap "$tap_name" 2>/dev/null || true
      brew install "$tap_pkg" || echo "Failed to install $tap_pkg"
    else
      echo "$pkg_name already installed"
    fi
  done
}

# Install cask packages
_install_casks() {
  local casks=("$@")
  for cask in "${casks[@]}"; do
    local cask_name=$(basename "$cask")
    echo "Installing $cask_name..."
    brew install --cask "$cask_name" || echo "Failed to install $cask_name"
  done
}

# Copy aerospace configuration
_copy_aerospace_config() {
  local config_source="$HOME/.config/aerospace.toml"
  local config_dest="$HOME/.aerospace.toml"

  if [ -f "$config_source" ]; then
    echo "Copying aerospace configuration..."
    cp "$config_source" "$config_dest" || echo "Failed to copy aerospace config"
  else
    echo "Aerospace config not found at $config_source"
  fi
}
