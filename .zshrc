# zsh settings

# || SHELL SETUP ||

# add directories to PATH
export PATH=$PATH:/home/negapmahs/.local/bin

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# source global shell alias files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"

# some default options
export EDITOR="nano"

# fix keybinds
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# || ZSH OPTIONS ||

# load modules
autoload -U compinit && compinit
autoload -U colors && colors

# source plugins
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
fpath+=(/usr/share/zsh/plugins/pure)

# pure options
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color cyan
zstyle ':prompt:pure:prompt:success' color magenta
zstyle ':prompt:pure:prompt:error' color red
zstyle :prompt:pure:git:stash show yes
prompt pure

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

# opts
setopt append_history inc_append_history share_history # better history
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell

# || SHELL INTEGRATIONS ||
eval "$(fzf --zsh)" # fzf history
eval "$(zoxide init --cmd cd zsh)" # replace cd command with zoxide
# check if
# 1.tmux exists on the system
# 2.we're in an interactive shell, and
# 3.tmux doesn't try to run within itself
# then, create a session named main OR attach an existing session named main
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi

# || OTHER OPTIONS ||
# fzf
export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget

# fff
# cd on exit
export FFF_HIDDEN=1 # show/hide hidden files
export FFF_FILE_ICON=1 # show/hide file icons
export FFF_GIT_CHANGES=1 # show/hide git status signs
export FFF_FILE_DETAILS=0 # show/hide file details
export FFF_LS_COLORS=1 # use LS_COLORS to color fff (on by default; overrides FF_COL[no.] if set)
export FFF_CD_ON_EXIT=0 # enable/disable cd on exit

# source syntax highlighting plugin bc it needs to be at the end of zshrc file
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
