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

# asdf 0.16+
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Poetry
export PATH="$HOME/.asdf/installs/poetry/1.7.1/bin:$PATH"

# ROOT
curr_asdf_py_ver=$(asdf current python | awk 'NR==2 {print $2}' | sed 's/^ *//' | cut -d. -f1,2 | tr -d '.')
curr_asdf_root_ver=$(asdf current root-python${curr_asdf_py_ver} | awk 'NR==2 {print $2}' | sed 's/^ *//')
thisroot="$HOME/.asdf/installs/root-python${curr_asdf_py_ver}/${curr_asdf_root_ver}/bin/thisroot.sh"
if test -f "$thisroot"; then
    source $thisroot
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

# GPG SSH agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
