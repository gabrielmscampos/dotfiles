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

# Git sign
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# ROOT
CURR_PYVERSION=$(python -c 'import sys; print("".join(str(n) for n in sys.version_info[:2]))')
THISROOT=/opt/ROOT-python${CURR_PYVERSION}/bin/thisroot.sh
if test -f "$THISROOT"; then
        source $THISROOT
fi

# Tunnel to CERN using sshuttle
tunnel_to_cern () {
    sshuttle --python=python3 --dns -v -r lxtunnel \
        10.0.0.0/8      \
        100.64.0.0/10   \
        10.100.0.0/16   \
        10.254.0.0/16   \
        10.76.0.0/15    \
        128.141.0.0/16  \
        128.142.0.0/16  \
        137.138.0.0/16  \
        172.16.0.0/12   \
        185.249.56.0/22 \
        188.184.0.0/15  \
        188.184.0.0/16  \
        188.185.0.0/15  \
        188.185.0.0/16  \
        192.16.155.0/24 \
        192.16.156.0/22 \
        192.16.160.0/22 \
        192.16.164.0/23 \
        192.16.166.0/24 \
        192.65.183.0/24 \
        192.65.184.0/21 \
        192.65.192.0/22 \
        192.65.196.0/23 \
        192.91.236.0/22 \
        192.91.240.0/22 \
        192.91.242.0/24 \
        192.91.244.0/23 \
        192.91.246.0/24 \
        194.12.128.0/18
}

# Tunnel to CMS P5 using sshuttle
tunnel_to_p5() {
    sshuttle --python=python3 --dns -v -r cmsusr 10.176.0.0/16
}

# If using AMD GPU gfx1031, we need to override GFX to pretend gfx1030
if command -v rocminfo &> /dev/null && rocminfo | grep -q "gfx1031";
then 
    export HSA_OVERRIDE_GFX_VERSION=10.3.0
fi

# Remap vim to nvim
alias vim='nvim'

