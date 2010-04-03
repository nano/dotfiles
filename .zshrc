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

gnu_userland_aliases() {
  grep --version | grep -q GNU && alias grep="grep --color=auto"
  ls --version | grep -q GNU && alias ls="ls --color=auto"
}

#
# Exports
#
export VISUAL="vim"
export EDITOR="vim"
export PAGER="less"
export PS1="%m:%c %B%(!.#.$)%b "
export PS2="%B>%b "
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export MANPATH="/usr/local/man:/usr/local/share/man:$MANPATH"

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
test -f ~/.ssh/config && {
  hosts=($(egrep "^Host.*" ~/.ssh/config | sed "s/^Host[ ]*\(.*\)$/\1/"))
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

#
# OS-specific settings
#
zsh_load_openbsd() {
  test -x /usr/local/bin/gls && alias ls="gls --color=auto"
}

zsh_load_freebsd() {
  alias ls="ls -G"
}

zsh_load_darwin() {
  test -d /opt/local && {
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export MANPATH="/opt/local/man:/opt/local/share/man:$MANPATH"
  }
  test -d /Developer/usr && {
    export PATH="/Developer/usr/bin:/Developer/usr/sbin:$PATH"
    export MANPATH="/Developer/usr/share/man:$MANPATH"
  }
  gnu_userland_aliases
}

os=$(uname | tr [:upper:] [:lower:])
type zsh_load_$os &>/dev/null && zsh_load_$os
unset os

test -e ~/.zshrc.local && source ~/.zshrc.local
