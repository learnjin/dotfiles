#!/usr/bin/env bash

set -o vi
set -o ignoreeof # ignore ctrl+d
stty -ixon # Disable ctrl-s and ctrl-q.

## HISTORY ##
export HISTFILESIZE=  HISTSIZE= #unlimited history
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups:ignorespace

## PS1
#export PS1='\W$(__git_ps1 " (%s)")\$ '
export PS1='\[\033[01;32m\]\W\[\033[00m\]\[\033[01;34m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\$ '

## CDPATH for more-efficient navigation ##
export CDPATH=.\
:${HOME}\


# COLORS ##
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

## OS SPECIFICS ##

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  [ -e "$HOME/.config/bashrc-linux" ] && source "$HOME/.config/bashrc-linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  [ -e "$HOME/.config/bashrc-darwin" ] && source "$HOME/.config/bashrc-darwin"
fi

## Local and private
[ -e "$HOME/.config/aliases" ] && source "$HOME/.config/aliases"
[ -e "$HOME/.config/bashrc_air" ] && source "$HOME/.config/bashrc_air"
[ -e "$HOME/.config/bashrc_me" ] && source "$HOME/.config/bashrc_me"

