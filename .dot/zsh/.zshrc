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
ZSH_PROFILE=1
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
RPROMPT='%(?.%F{green}.%F{red}[%?] - )%B%D{%H:%M:%S}%b%f'

builtin source ~/.zinit/bin/zinit.zsh

module_path+=( "/home/zinit/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin

## ZINIT
## Load Local Modules
zinit lucid light-mode for \
        id-as"module/gnupath"       $MODULE_DIR/gnupath \
        id-as"module/aliases"       $MODULE_DIR/aliases \
        id-as"module/colored-man"   $MODULE_DIR/colored-man \
        id-as"module/history"       $MODULE_DIR/history \
        id-as"module/dircolor"      $MODULE_DIR/dircolor \
        id-as"module/completion"    $MODULE_DIR/completion

## Load external plugins
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions
zinit ice wait lucid compile'{src/*.zsh,src/strategies/*}' atinit"ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=69'" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!' lucid
zinit light zsh-users/zsh-history-substring-search
zinit ice wait lucid atinit"ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)"
zinit light zsh-users/zsh-syntax-highlighting
#zinit ice wait'!' lucid
#zinit light zsh-users/zsh-history-substring-search

# Set highlighters
#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
#ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
#ZSH_HIGHLIGHT_PATTERNS+=('brew install *' 'fg=white,bold,bg=green')

# Set color of autosuggestions and ignore leading spaces
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=69'

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
