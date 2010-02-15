#
# Aliases
#
alias ecoh="echo"
alias mtr="mtr --curses"
alias m="mtr"
alias ll="ls -l"
alias l="ls -lA"
alias s="ssh -l root"
alias n="nmap -sP"
alias sc="./script/console"
alias ..="cd .."
alias ...="cd ../.."

#
# Exports
#
export VISUAL="vim"
export EDITOR="vim"
export PAGER="less"
export PS1="%m:%c %B%(!.#.$)%b "
export PS2="%B>%b "
export PATH="$PATH:$HOME/.bin"

#
# Options
#
setopt nobeep
setopt appendhistory
setopt nosharehistory
setopt nonomatch

#
# History
#
export HISTSIZE=5000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=5000

#
# Functions
#
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

#
# Completion
#
autoload -U compinit
compinit

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#
# Complete SSH hosts
#
if [ -f "$HOME/.ssh/config" ]; then
  hosts=($(egrep "^Host.*" "$HOME/.ssh/config" | sed "s/^Host[ ]*\(.*\)$/\1/"))
  zstyle "*" hosts $hosts
fi

#
# Key Bindings
#
bindkey -e

bindkey "\e[1~" beginning-of-line
bindkey "\e[2~" overwrite-mode
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
bindkey "\e[5~" history-beginning-search-backward
bindkey "\e[6~" history-beginning-search-forward
bindkey "\e[7~" beginning-of-line
bindkey "\e[H"  beginning-of-line
bindkey "\eOH"  beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[F"  end-of-line
bindkey "\eOF"  end-of-line
bindkey "\e[3^" delete-word

#
# OS-specific settings
#
case "$(uname)" in
OpenBSD)
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  test -x "/usr/local/bin/gls" && alias ls="gls --color=auto"
  alias shred="rm -P"
  ;;
FreeBSD)
  test -x "/usr/local/bin/gnuwatch" && alias watch="gnuwatch"
  alias shred="rm -P"
  alias ls="ls -G"
  ;;
Linux)
  alias ls="ls --color=auto"
  alias grep="grep --color=auto"
  ;;
Darwin)
  alias ls="ls -G"
  alias shred="rm -P"
  test -x "/opt/local/bin/grep" && alias grep="grep --color=auto --exclude=.svn"
  test -x "/opt/local/bin/gseq" && alias seq="gseq"
  export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
  export MANPATH="/opt/local/share/man:/usr/local/man:$MANPATH"

  if [ -d "/usr/texbin" ]; then
    export PATH="/usr/texbin:$PATH"
    export MANPATH="/usr/texbin/man:$MANPATH"
  fi

  if [ -d "/usr/local/mysql/bin" ]; then
    export PATH="/usr/local/mysql/bin:$PATH"
    export MANPATH="/usr/local/mysql/man:$MANPATH"
  fi

  if [ -d "/Developer/usr" ]; then
    export PATH="/Developer/usr/bin:/Developer/usr/sbin:$PATH"
    export MANPATH="/Developer/usr/share/man:$MANPATH"
  fi
  ;;
esac

test -e "$HOME/.zshrc.local" && source "$HOME/.zshrc.local"
