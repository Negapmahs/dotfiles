# zsh settings

# || SHELL SETUP ||

# add directories to PATH
export PATH=/home/negapmahs/.local/bin:$PATH

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# source global shell alias files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/alias2" ] && source "$XDG_CONFIG_HOME/shell/alias2"

# some default options
export EDITOR=nano

# fix keybinds
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

# || PLUGINS ||

# load modules
autoload -U compinit; compinit -d $XDG_CACHE_HOME/zsh/zcompdump

# source fzf-tab
source $XDG_DATA_HOME/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# source pure
fpath+=($XDG_DATA_HOME/zsh/plugins/pure)

# autoload of promptinit needs to occur AFTER setting fpath
autoload -U promptinit; promptinit

# pure options
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:environment:node_version show yes
zstyle :prompt:pure:git:dirty detailed yes

# initialise pure
prompt pure

# source fast-syntax-highlighting
source $XDG_DATA_HOME/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# || ZSH OPTIONS ||
# history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history" # move histfile to cache

# opts
setopt append_history inc_append_history share_history hist_ignore_all_dups hist_ignore_space # better history
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt globdots # include dotfiles when globbing
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell

# || SHELL INTEGRATIONS ||

# fzf
eval "$(fzf --zsh)"

# tmux
#  check if
#  1.tmux exists on the system
#  2.we're in an interactive shell, and
#  3.tmux doesn't try to run within itself
#  then, create a session named main OR attach an existing session named main
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi

# || OTHER OPTIONS ||
# fzf configuration
export FZF_DEFAULT_OPTS="--style minimal --layout reverse --info inline-right --preview 'bat -p --color always {}'"
export FZF_CTRL_R_OPTS="--style minimal --layout reverse --info inline-right --no-sort --no-preview"
export FZF_ALT_C_OPTS="--style minimal --layout reverse --info inline-right --no-preview"

# clean up home folder
export LESSHISTFILE=$XDG_CACHE_HOME/lesshist
