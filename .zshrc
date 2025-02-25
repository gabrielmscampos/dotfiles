# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git asdf zsh-autosuggestions zsh-syntax-highlighting)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Preferred editor
export EDITOR='vim'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Stop foot terminal confusing ssh
if [[ $TERM = "foot" ]]; then
    alias ssh='TERM=linux ssh'
fi

# Poetry
export PATH="$HOME/.asdf/installs/poetry/1.7.1/bin:$PATH"

# ROOT
CURR_PYVERSION=$(python -c 'import sys; print("".join(str(n) for n in sys.version_info[:2]))')
THISROOT=/opt/ROOT-python${CURR_PYVERSION}/bin/thisroot.sh
if test -f "$THISROOT"; then
        source $THISROOT
fi

# If using AMD GPU gfx1031, we need to override GFX to pretend gfx1030
if command -v rocminfo &> /dev/null && rocminfo | grep -q "gfx1031";
then 
    export HSA_OVERRIDE_GFX_VERSION=10.3.0
fi

# Remap vim to nvim
alias vim='nvim'

# Load scripts
export PATH="$HOME/.scripts:$PATH"
