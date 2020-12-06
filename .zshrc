# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ehud/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions poetry)
# plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-search-backward

export EDITOR="nvim"
export BROWSER="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"

cd ~/nym/au
# source ~/nym/env/bin/activate
alias python="/usr/bin/python3.7"
alias start="explorer.exe"
# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export LESS="-F -X $LESS"

# export PYTHONBREAKPOINT="IPython.embed"
export PYTHONBREAKPOINT="coding.treats.tools.remote_pycharm_debug"

export GOOGLE_APPLICATION_CREDENTIALS=/home/ehud/nym/anki/inbound-planet-201708-054c397157b0.json

source $HOME/.poetry/env

poweron() {
    set -x
    aws ec2 start-instances --instance-ids $(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
poweroff() {
    set -x
    aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
resize() {
    set -x
    aws ec2 modify-instance-attribute --instance-id $(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .) --instance-type "{\"Value\": \"$2\"}"
}

git config --global alias.ammend 'commit --amend --no-edit'
git config --global alias.openpr '!"$BROWSER" "https://bitbucket.org/nymhealth/au/pull-requests/new?source=$(git symbolic-ref --short HEAD)"'
git config --global alias.pushu "push -u origin HEAD"
git config --global alias.runab '!run_test() {
    set -x
    git pull origin develop --no-edit
    git push
    url="https://jenkins.analytics.nymhealth.com/job/Coding%20Flow%20A-B%20Test/job/develop"
    test_id=""
    charts_amount="&RANDOM_CHARTS_NUMBER=1500"
    parsers=""
	while getopts "t:c:p:" opt; do
		case "$opt" in
		t)  test_id="&CHOOSE_SAME_CHARTS_OF_TEST_ID="$OPTARG
            # charts_amount=""
			;;
		c)  charts_amount="&RANDOM_CHARTS_NUMBER="$OPTARG
			;;
		p)  parsers="&PARSERS="$OPTARG
			;;
		esac
	done
    echo $parsers
    curl -D - -X POST $url"/buildWithParameters?dealy=0sec&AU_BRANCH="$(git symbolic-ref --short HEAD)"&TEST_TITLE="$(git symbolic-ref --short HEAD)"%20ab%20test"$test_id$charts_amount$parsers --user ehud:<SET_ME_TO_TOKEN>
    # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure

    "$BROWSER" $url
}; run_test'
git config --global alias.runtest '!run_test() {
    url="https://jenkins.analytics.nymhealth.com/job/Coding%20Flow/job/develop"
    test_id=""
    charts_amount="&RANDOM_CHARTS_NUMBER=1500"
    parsers=""
	while getopts "t:c:p:" opt; do
		case "$opt" in
		t)  test_id="&CHOOSE_SAME_CHARTS_OF_TEST_ID="$OPTARG
            # charts_amount=""
			;;
		c)  charts_amount="&RANDOM_CHARTS_NUMBER="$OPTARG
			;;
		p)  parsers="&PARSERS="$OPTARG
			;;
		esac
	done
    echo $parsers
    curl -D - -X POST $url"/buildWithParameters?dealy=0sec&AU_BRANCH="$(git symbolic-ref --short HEAD)"&TEST_TITLE="$(git symbolic-ref --short HEAD)"%20ab%20test"$test_id$charts_amount$parsers --user ehud:<SET_ME_TO_TOKEN>
    # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure

    "$BROWSER" $url
}; run_test'

eval "$(starship init zsh)"
