# === ZINIT BOOTSTRAP ===
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# === PLUGINS ===
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

# === HISTORY ===
HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=5000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# === OPTIONS ===
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt CORRECT
setopt NO_BEEP

# === KEYBINDS ===
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# === COMPLETION ===
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# === AUTOSUGGESTION STYLE ===
# muted from Rosé Pine — subtle, not distracting
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6e6a86'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# === ALIASES ===
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias cls='clear'

# === STARSHIP ===
eval "$(starship init zsh)"

export BAT_THEME="rose-pine-moon"
