# Path to your oh-my-zsh installation.
export GOPATH=~/sandbox/go
export ZSH=/Users/viviannguyen/.oh-my-zsh
export PATH=/usr/local/bin:$PATH:$GOPATH/bin:/usr/local/mysql/bin

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ctags="`brew --prefix`/bin/ctags"
# alias vim="/usr/local/Cellar/vim/8.0.0647/bin/vim"
alias vim="nvim"

# git
alias gp="git checkout development && git pull origin development"
alias gr="git rebase development"
alias gc="git commit -m"
alias undo="git reset --soft 'HEAD^'"

# db alias
alias mystage="mysql --login-path=stage --prompt='[ !!!stage!!! ] > '"
alias prod="mysql --login-path=production --prompt='[ !!!prod!!! ] > '"

# build and run, pipe stderr to a log file
# tail and pretty print errors. holy fuck.
alias tail_api="tail -f ~/.api_err.log | sed 's/\\\n/\\
/g;s/\\\t/    /g'"

# $1 is module, $2 is specific test
go_test() {
    if [ -z "$2" ]
        then
            DB_USER=root go test -v -p 1 $1 2> >(sed 's/\\n/\
        /g;s/\\t/   /g' > delme.test_err.log) > delme.test_out.log
        else
            DB_USER=root go test -v -p 1 $1 -run $2 2> >(sed 's/\\n/\
        /g;s/\\t/   /g' > delme.test_err.log) > delme.test_out.log
    fi
}

alias test_api=go_test

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
