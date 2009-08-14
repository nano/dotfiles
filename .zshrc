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
export PS1=" %m:%c %B%(!.#.$)%b "
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
# Completion
#
autoload -U compinit
compinit -C

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
  export MANPATH="/opt/local/share/man:$MANPATH"

  if [ -d "/usr/texbin" ]; then
    export PATH="/usr/texbin:$PATH"
    export MANPATH="/usr/texbin/man:$MANPATH"
  fi

  if [ -d "/usr/local/mysql/bin" ]; then
    export PATH="/usr/local/mysql/bin:$PATH"
    export MANPATH="/usr/local/mysql/man:$MANPATH"
  fi
  ;;
esac

#
# Create the given directory and cd into it immediately.
#
mkcd() {
  mkdir $1
  cd $1
}

#
# Add SSH keys to ssh-agent.
#
addsshkeys() {
  ssh-add -L &>/dev/null

  if [ $? -ne 2 ]; then
    local need="$(cat $HOME/.ssh/id_rsa.pub | cut -d ' ' -f 1-2)"
    local have="$(ssh-add -L | cut -d ' ' -f 1-2)"

    if ! echo "$have" | grep -q "$need"; then
      ssh-add
    fi
  fi
}

#
# ssh-copy-id
#
if ! which ssh-copy-id &>/dev/null; then
  ssh-copy-id() {
    cat "$HOME/.ssh/id_rsa.pub" | ssh $@ "cat >> .ssh/authorized_keys"
  }
fi

#
# View a RFC paper.
#
rfc() {
  if [ $# -ne 1 ]; then
    echo "Usage: $0 <rfc>"
    return 1
  fi

  if ! which lynx &>/dev/null; then
    echo "lynx not found"
    return 2
  fi

  lynx -dump "http://www.ietf.org/rfc/rfc$1.txt" | $PAGER
}

#
# Show the content of an archive.
#
lsar() {
  if [ $# -ne 1 -o ! -f "$1" ]; then
    echo "Usage: $0 <file>"
    return 1
  fi

  case "$1" in
  *.tar.gz|*.tgz)
    tar -ztf "$1"
    ;;
  *.tar.bz2|*.tbz)
    tar -jtf "$1"
    ;;
  *.tar)
    tar -tf "$1"
    ;;
  *.zip)
    unzip -l "$1"
    ;;
  *)
    echo "Unrecognized file type: $1"
    return 2
    ;;
  esac
}

#
# Extract an archive.
#
extr() {
  case "$1" in
  *.rar)
    unrar x $1
    ;;
  *.zip)
    unzip $1
    ;;
  *.tar)
    tar xf $1
    ;;
  *.tar.gz|*.tgz)
    tar xzf $1
    ;;
  *.tar.bz2|*.tbz)
    tar xjf $1
    ;;
  *.cpio)
    cpio -id < $1
    ;;
  *)
    echo "Unrecognized file type: $1"
    return 1
    ;;
  esac
}

#
# Reload zsh configuration.
#
update-zsh() {
  autoload -U zrecompile

  test -f $HOME/.zshrc && zrecompile -p $HOME/.zshrc
  test -f $HOME/.zcompdump && zrecompile -p $HOME/.zcompdump
  test -f $HOME/.zshrc.zwc.old && rm -f $HOME/.zshrc.zwc.old
  test -f $HOME/.zcompdump.zwc.old && rm -f $HOME/.zcompdump.zwc.old

  source $HOME/.zshrc
}

test -e "$HOME/.zshrc.local" && source "$HOME/.zshrc.local"
