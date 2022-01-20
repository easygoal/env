#!/bin/bash

# alias
alias ll='ls -l'
alias g='gvim'

export PATH=$HOME/.local/bin:$PATH

# WSL1
#export DISPLAY=:0.0

# WSL2
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0.0
#$export LIBGL_ALWAYS_INDIRECT=1
