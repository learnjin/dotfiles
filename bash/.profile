#!/bin/sh
# Profile file. Runs on login.

export EDITOR='nvim'
# export TERMINAL='alacritty'
export PAGER=less
export LESS=XR      # colors
export BLOCKSIZE=K  # du, df, “coreutils” will respect this

# source bashrc if not already happened
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"
