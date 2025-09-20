#!/bin/bash

# Personal dotfiles configuration installer for macOS
# Usage: curl -fsSL https://raw.githubusercontent.com/Pixxle/config/main/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONFIG_DIR="$HOME/.config"
REPO_URL="https://github.com/Pixxle/config.git"

# Logging functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
  if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This installer is designed for macOS only."
    exit 1
  fi
  log_success "macOS detected"
}

# Install Homebrew if not present
install_homebrew() {
  if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    log_success "Homebrew installed"
  else
    log_success "Homebrew already installed"
  fi
}

# Clone or update configuration repository
setup_config_repo() {
  if [ -d "$CONFIG_DIR" ]; then
    log_info "Configuration directory exists, updating..."
    cd "$CONFIG_DIR"
    git pull origin main
  else
    log_info "Cloning configuration repository..."
    git clone "$REPO_URL" "$CONFIG_DIR"
    cd "$CONFIG_DIR"
  fi
  log_success "Configuration repository ready"
}

# Install packages
install_packages() {
  log_info "Installing packages..."
  source "$CONFIG_DIR/shell/functions.d/setup.sh"
  install-common-tools
  log_success "Packages installed"
}

# Install and setup zsh with Oh My Zsh
setup_zsh() {
  log_info "Setting up zsh and Oh My Zsh..."

  SHELL_LOAD_LINE="source $CONFIG_DIR/shell/load.sh"

  # Set zsh as default shell if not already
  if [ "$SHELL" != "$(which zsh)" ]; then
    log_info "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    log_success "zsh set as default shell"
  fi

  # Install Oh My Zsh if not present
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "Oh My Zsh installed"
  else
    log_success "Oh My Zsh already installed"
  fi

  # For zsh
  if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "$SHELL_LOAD_LINE" "$HOME/.zshrc"; then
      echo "$SHELL_LOAD_LINE" >>"$HOME/.zshrc"
      log_success "Added to .zshrc"
    fi
  fi

}

# Setup custom .zshrc configuration
setup_zshrc() {
  log_info "Configuring .zshrc..."

  # Backup existing .zshrc
  if [ -f "$HOME/.zshrc" ] && [ ! -f "$HOME/.zshrc.backup" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    log_info "Backed up existing .zshrc"
  fi

  # Create new .zshrc
  cat >"$HOME/.zshrc" <<'EOF'
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="robbyrussell"

# Plugins (git plugin enabled but aliases disabled)
plugins=(git)

# Disable git plugin aliases to use our custom ones
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Disable Oh My Zsh git aliases
disable_git_aliases() {
    # Remove git aliases from Oh My Zsh git plugin
    unalias -m 'g*' 2>/dev/null || true
    unalias -m 'git*' 2>/dev/null || true
    
    # Remove numbered aliases (1-9) from Oh My Zsh
    unalias -m '1' 2>/dev/null || true
    unalias -m '2' 2>/dev/null || true
    unalias -m '3' 2>/dev/null || true
    unalias -m '4' 2>/dev/null || true
    unalias -m '5' 2>/dev/null || true
    unalias -m '6' 2>/dev/null || true
    unalias -m '7' 2>/dev/null || true
    unalias -m '8' 2>/dev/null || true
    unalias -m '9' 2>/dev/null || true
    
    # Remove directory navigation aliases from Oh My Zsh
    unalias -m '..*' 2>/dev/null || true
    unalias -m '-' 2>/dev/null || true
}

# Call the function to disable git aliases
disable_git_aliases

# Load our custom configuration
source ~/.config/shell/load.sh
EOF

  log_success ".zshrc configured"
}

setup_neovim() {
  log_info "Setting up Neovim..."

  # Neovim will automatically install plugins on first run
  # We can trigger this by running a simple command
  if command -v nvim &>/dev/null; then
    log_info "Triggering Neovim plugin installation..."
    nvim --headless +qall 2>/dev/null || true
    log_success "Neovim configured"
  else
    log_warning "Neovim not found, skipping plugin setup"
  fi
}

# Main installation function
main() {
  log_info "Starting dotfiles installation..."

  check_macos
  install_homebrew
  setup_config_repo
  install_packages
  setup_zsh
  setup_neovim

  log_success "Installation complete!"
  log_info "Please restart your terminal or run: source ~/.zshrc"
  log_info "Your dotfiles are now configured and ready to use."
}

# Run the installation
main "$@"
