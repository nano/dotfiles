#
# Aliases
#
alias mtr="mtr --curses"
alias m="mtr"
alias ll="ls -l"
alias l="ls -lA"
alias s="ssh -l root"
alias n="nmap -sP"
alias rmkh="ssh-keygen -R"
alias ..="cd .."
alias ...="cd ../.."
alias be="bundle exec"

#
# Exports
#
export VISUAL="vim"
export EDITOR="vim"
export PAGER="less"
export PS1="%m:%c %B%(!.#.$)%b "
export PS2="%B>%b "
export PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"

#
# Options
#
setopt nobeep
setopt appendhistory
setopt nosharehistory
setopt nonomatch
setopt localoptions
setopt localtraps

#
# History
#
export HISTSIZE=5000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=5000

#
# Completion
#
autoload -U compinit
compinit

#
# Complete SSH hosts
#
test -f $HOME/.ssh/config && {
  hosts=($(egrep "^Host.*" $HOME/.ssh/config | sed "s/^Host[ ]*\(.*\)$/\1/"))
  zstyle "*" hosts $hosts
  unset hosts
}

#
# Key Bindings
#
bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
bindkey "\e[5~" history-beginning-search-backward
bindkey "\e[6~" history-beginning-search-forward
bindkey "\e[H"  beginning-of-line
bindkey "\e[F"  end-of-line
bindkey "\eOH"  beginning-of-line
bindkey "\eOF"  end-of-line

#
# Linux
#
zsh_linux() {
  alias ls="ls --color=auto"
  alias grep="grep --color=auto"
}

#
# OpenBSD
#
zsh_openbsd() {
  test -x /usr/local/bin/gls && alias ls="gls --color=auto"
  test -x /usr/local/bin/ggrep && alias grep="ggrep --color=auto"
}

#
# FreeBSD
#
zsh_freebsd() {
  alias ls="ls -G"
  alias grep="grep --color=auto"
}

#
# Mac OS X
#
zsh_darwin() {
  test -x $HOME/.homebrew/bin/ls && alias ls="ls --color=auto"
  alias grep="grep --color=auto"
}

#
# Load OS-specific options
#
os=$(uname | tr [:upper:] [:lower:])
type zsh_$os &>/dev/null && zsh_$os
unset zsh_$os
unset os

#
# ssh-copy-id
#
if ! which ssh-copy-id &> /dev/null; then
  ssh-copy-id() {
    cat $HOME/.ssh/id_rsa.pub | ssh $@ "mkdir -p .ssh &>/dev/null ; cat >> .ssh/authorized_keys"
  }
fi

test -e $HOME/.zshrc.local && source $HOME/.zshrc.local
