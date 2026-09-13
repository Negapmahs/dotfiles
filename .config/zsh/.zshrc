# zsh settings

# || SHELL SETUP ||

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

# prefix XDG_BIN_HOME to PATH so that custom scripts and binaries are executed first
export PATH="$XDG_BIN_HOME":"$PATH"

[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/alias2" ] && source "$XDG_CONFIG_HOME/shell/alias2"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# || PLUGINS ||

autoload -U compinit; compinit -d $XDG_CACHE_HOME/zsh/zcompcache
source $XDG_DATA_HOME/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

fpath+=($XDG_DATA_HOME/zsh/plugins/pure)
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:environment:node_version show yes
zstyle :prompt:pure:git:dirty detailed yes
prompt pure

source $XDG_DATA_HOME/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# || ZSH OPTIONS ||
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$XDG_STATE_HOME/zsh/history # move histfile to cache

setopt append_history inc_append_history share_history hist_ignore_all_dups hist_ignore_space # better history
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt globdots # include dotfiles when globbing
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell

# || SHELL INTEGRATIONS ||
eval "$(fzf --zsh)"

# || OTHER OPTIONS ||
export FZF_DEFAULT_OPTS="--style minimal --layout reverse --info inline-right --preview 'bat -p --color always {}'"
export FZF_CTRL_R_OPTS="--style minimal --layout reverse --info inline-right --no-sort --no-preview"
export FZF_ALT_C_OPTS="--style minimal --layout reverse --info inline-right --no-preview"

# clean up home folder
export LESSHISTFILE=$XDG_CACHE_HOME/lesshist
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
