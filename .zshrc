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

# Stop kitty terminal confusing ssh
if [[ $TERM = "xterm-kitty" ]]; then
    alias ssh='TERM=linux ssh'
fi

# asdf 0.16+
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# ROOT
curr_asdf_py_ver=$(asdf current python | awk 'NR==2 {print $2}' | sed 's/^ *//' | cut -d. -f1,2 | tr -d '.')
curr_asdf_root_ver=$(asdf current root-python${curr_asdf_py_ver} | awk 'NR==2 {print $2}' | sed 's/^ *//')
thisroot="$HOME/.asdf/installs/root-python${curr_asdf_py_ver}/${curr_asdf_root_ver}/bin/thisroot.sh"
if test -f "$thisroot"; then
    source $thisroot
fi

# Remap vim to nvim
alias vim='nvim'

# Load scripts
export PATH="$HOME/.scripts:$PATH"

# GPG SSH agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
