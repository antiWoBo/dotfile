# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# add by xudifsd
# for mac
export CLICOLOR=1
export GREP_OPTIONS="--color=auto"
if [ -d ~/bin ]; then
    export PATH=$PATH:~/bin
fi
if [ -f ~/.git-completion.sh ];then
    source ~/.git-completion.sh
fi

export EDITOR=vim
alias vi='vim'
alias sudo='sudo '	#makes you could use config of your own
alias run='runjava.sh'	#make it's easy to compile java program and run it
alias wget='wget -c --read-timeout=15 --tries=100'	#make wget download faster in slow Internet connection situation
#alias curl='curl -C - -m 60 --retry 100'
alias sig='ctags -R --c-kinds=+p --fields=+S .'	#code_complete will use tags to scan prototype of function
alias csi='csi -quiet'	#make csi start without message
alias clisp='clisp -q'	#make clisp start without message
alias copychromecache='find .cache/google-chrome/Default/Cache -type f |\
					  xargs file|\
					  grep -v JPEG|grep -v ASCII | grep -v HTML|grep -v gzip|grep -v PNG|grep -v data | grep -v text|\
					  cut -f1 -d ":"|\
					  xargs copy_to_home_temp.sh'
alias openvpn="sudo openvpn /etc/openvpn/vip.conf"
alias free="free -m"

export PYTHONSTARTUP=~/.pythonstartup.py	#this is use .pythonstartup.py as a start script to add atuo-complete function to python interpreter

export LD_LIBRARY_PATH=/usr/local/lib	#this is for libgit2
export CHICKEN_DOC_REPOSITORY=/home/xudifsd/Downloads/chicken-doc/
export CHICKEN_DOC_PAGER=less
export MAIL=/var/spool/mail/xudifsd

#using powerline plugin in bash prompt
function _update_ps1() {
    export PS1="$(~/dev/powerline-shell/powerline-shell.py $?)"
    # http://unix.stackexchange.com/a/104278/167587 for tmux
    PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
}

export PROMPT_COMMAND="_update_ps1"

#for http://www.vanheusden.com/httping/
alias httping='httping -S -Y -Z -s --offset-yellow 370 --offset-red 380'

alias xclip="xclip -selection c"
alias jcc="java -jar ~/bin/jasmin.jar"
alias smali="java -jar ~/bin/smali.jar"
alias baksmali="java -jar ~/bin/baksmali-2.0.2.jar"
alias dx="java -jar ~/bin/dx.jar --dex"
alias antlr="java org.antlr.Tool"
alias jdb="rlwrap jdb"
alias cdc="cd /Users/xudifsd/dev/core.typed"
alias fuck='sudo $(history -p \!\!)'
alias cds='cd ~/dev/snitch'
alias cdn='cd ~/dev/nimbus'
alias cdp='cd ~/dev/pensieve'

function stop_nrepl {
    kill -SIGKILL `lsof -i:16180 | tail -n 1 | awk '{printf "%s\n",$2}'`
}

alias nrepl='nohup lein repl :headless :port 16180 > /tmp/nrepl-out 2>&1 &'
alias repl='lein repl :connect 16180'
alias nstop='stop_nrepl'

alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias ,,,,,,='cd ../../../../../..'
alias ,,,,,,,='cd ../../../../../../..'
alias ,,,,,,,,='cd ../../../../../../../..'
alias ,,,,,,,,,='cd ../../../../../../../../..'
alias ,,,,,,,,,,='cd ../../../../../../../../../..'

# http://stackoverflow.com/a/30370259/845762
alias tmuxl='for i in `ps aux | grep -w [t]mux | awk "{print $2}"` ; do kill -USR1 $i ; done ; tmux list-session'
alias tmuxa='for i in `ps aux | grep -w [t]mux | awk "{print $2}"` ; do kill -USR1 $i ; done ; tmux attach-session'

# https://unix.stackexchange.com/questions/1045/getting-256-colors-to-work-in-tmux
alias tmux='TERM=xterm-256color tmux'
alias ssh='TERM=xterm ssh'

alias pdf2htmlEX='pdf2htmlEX --fit-width 1024 --embed-outline 0'

# sudo /Library/StartupItems/VirtualBox/VirtualBox restart#run this before vagrant up

export LC_ALL=en_US.UTF-8
export GOROOT=/usr/local/go

# online dev machine usually set screen prefix as ctrl-a, this conflict with
# `go to start of line` in emacs mode, so better change it into vi mode
# set -o vi

#if [ -f `brew --prefix`/etc/bash_completion.d/go ]; then
#    source `brew --prefix`/etc/bash_completion.d/go
#fi

#[[ -z "$TMUX" ]] && exec tmux -2 -f ~/.tmux.conf
[[ -s "/home/xudi/.jumbo/etc/bashrc" ]] && source "/home/xudi/.jumbo/etc/bashrc"
