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

builtin source ${HOME}/.zcomet/bin/zcomet.zsh

#declare -A MODULES
MODULES=(
    aliases
    history
    colored-man
    dircolor
    completion
)

#Source module files
for module in $MODULES; do
  zcomet snippet "$MODULE_DIR/$module/$module.zsh"
done

#zcomet snippet $MODULE_DIR/aliases/aliases.zsh
#zcomet snippet $MODULE_DIR/history/history.zsh
#zcomet snippet $MODULE_DIR/colored-man/colored-man.zsh
#zcomet snippet $MODULE_DIR/dircolor/dircolor.zsh
#zcomet snippet $MODULE_DIR/completion/completion.zsh

#zcomet load marlonrichert/zsh-autocomplete

#declare -A PLUGINS
PLUGINS=(
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
)

#Source plugin files
for plug in $PLUGINS; do
  zcomet load $plug
done

#zcomet load zsh-users/zsh-syntax-highlighting
# Set highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('brew install *' 'fg=white,bold,bg=green')

#zcomet load zsh-users/zsh-autosuggestions
# Set color of autosuggestions and ignore leading spaces
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=69'

#zcomet load zsh-users/zsh-history-substring-search
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
