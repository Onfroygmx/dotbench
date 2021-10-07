#!/usr/bin/env zsh
#!/bin/zsh
#   ______    _
#  |___  /   | |
#     / / ___| |__  _ __ ___
#    / / / __| '_ \| '__/ __|
#  ./ /__\__ \ | | | | | (__
#  \_____/___/_| |_|_|  \___|
#

#
# Zprofile
#
ZSH_PROFILE=0
if [ $ZSH_PROFILE -gt 0 ]; then
  zmodload zsh/zprof
fi

## Load custom functions
# Add current functions dir to fpath and autoload functions
#fpath+=("$ZDOTDIR/functions")
# Autoload custom functions
#autoload -Uz $fpath[-1]/*(.:t)

# Disable all beeps
setopt no_beep

## Set prompt
# Verry simple prompt
PROMPT='%F{green}%n%f %F{cyan}%(4~|%-1~/.../%2~|%~)%f %F{magenta}%B>%b%f '
RPROMPT='%(?.%F{green}.%F{red}[%?] - )%B%D{%H:%M:%S}%b%f'#

builtin source ~/.zpm/zpm.zsh

zpm load @file/aliases,origin:$MODULE_DIR/aliases/aliases.zsh
#zpm load @link/aliases,origin:$MODULE_DIR/aliases/,source:aliases.zsh
#zpm load @link/plugin,origin:$MODULE_DIR/aliases/,source:aliases.zsh
zpm load @file/history,origin:$MODULE_DIR/history/history.zsh
#zpm load @link/history,origin:$MODULE_DIR/history/,source:history.zsh
#zpm load @link/plugin,origin:$MODULE_DIR/history/,source:history.zsh
zpm load @file/colored-mand,origin:$MODULE_DIR/colored-man/colored-man.zsh
#zpm load @link/colored-man,origin:$MODULE_DIR/colored-man/,source:colored-man.zsh
#zpm load @link/plugin,origin:$MODULE_DIR/colored-man/,source:colored-man.zsh
zpm load @file/dircolor,origin:$MODULE_DIR/dircolor/dircolor.zsh
#zpm load @link/dircolor,origin:$MODULE_DIR/dircolor/,source:dircolor.zsh
#zpm load @link/plugin,origin:$MODULE_DIR/dircolor/,source:dircolor.zsh
zpm load @file/completion,origin:$MODULE_DIR/completion/completion.zsh
#zpm load @link/completion,origin:$MODULE_DIR/completion/,source:completion.zsh
#zpm load @link/plugin,origin:$MODULE_DIR/completion/,source:completion.zsh


zpm load zsh-users/zsh-syntax-highlighting,origin:https://github.com/zsh-users/zsh-syntax-highlighting
# Set highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('brew install *' 'fg=white,bold,bg=green')

zpm load zsh-users/zsh-autosuggestions
# Set color of autosuggestions and ignore leading spaces
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=69'

zpm load zsh-users/zsh-history-substring-search
# Set history search options
HISTORY_SUBSTRING_SEARCH_FUZZY=set
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=set
# Bind ^[[A/^[[B for history search after sourcing the file
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## Initialize compinit
run-compinit

#
# Zprofile
#
if [ $ZSH_PROFILE -gt 0 ]; then
  now=$(date | awk -F ',' '{ printf "%s %s", $1, $2 }' | awk '{ printf "%s-%s_%s", $2, $3, $5 }')
  [[ ! -d "$ZSH_CACHE_DIR/zprof" ]] && mkdir -p "$ZSH_CACHE_DIR/zprof"
  LC_NUMERIC="en_US.UTF-8" zprof >> $ZSH_CACHE_DIR/zprof/$now.zprofile
  LC_NUMERIC="en_US.UTF-8" zprof | awk 'NR == 3 { print "Startup Time: ", $3/$8*100, "ms"}'
fi
