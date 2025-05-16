# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting kubectl kubectx)
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

export EDITOR="vim"
export BROWSER="open"

cd ~/projects/au
source ~/projects/env3.11/bin/activate
# alias python="/usr/bin/python3.7"
# alias start="explorer.exe"
# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

#export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_STRATEGY=(history)
export LESS="-F -X $LESS"

# export PYTHONBREAKPOINT="IPython.embed"
export PYTHONBREAKPOINT="biscuits.tools.remote_pycharm_debug"

export GOOGLE_APPLICATION_CREDENTIALS=/home/ehud/nym/anki/inbound-planet-201708-054c397157b0.json

source $HOME/.poetry/env

poweron() {
    set -x
    aws ec2 --profile ehud_user start-instances --instance-ids $(aws ec2 --profile ehud_user describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
poweroff() {
    set -x
    aws ec2 --profile ehud_user stop-instances --instance-ids $(aws ec2 --profile ehud_user describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
powerofff() {
    set -x
    aws ec2 --profile ehud_user stop-instances -f --instance-ids $(aws ec2 --profile ehud_user describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
resize() {
    set -x
    aws ec2 --profile ehud_user modify-instance-attribute --instance-id $(aws ec2 --profile ehud_user describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .) --instance-type "{\"Value\": \"$2\"}"
}
assh() {
        #ssh  -o "IdentitiesOnly=yes" -i ~/.ssh/aws-admin $1@$(aws ec2 describe-instances --instance-id $2 --output text --query 'Reservations[0].Instances[0].PrivateIpAddress')
        ssh  -o "IdentitiesOnly=yes" $1@$(aws ec2 --profile ehud_user describe-instances --instance-id $2 --output text --query 'Reservations[0].Instances[0].PrivateIpAddress')
}

git config --global alias.co 'checkout'
git config --global alias.ammend 'commit --amend --no-edit'
git config --global alias.commitmb '!git commit -m $(git symbolic-ref --short HEAD)'
git config --global alias.pushu "push -u origin HEAD"
# git config --global alias.openpr '!git pushu; "$BROWSER" "https://bitbucket.org/nymhealth/$(basename `git rev-parse --show-toplevel`)/pull-requests/new?source=$(git symbolic-ref --short HEAD)"'
git config --global alias.openpr '!git pushu; "$BROWSER" "https://github.com/Nym-Health/$(basename `git rev-parse --show-toplevel`)/compare/$(git symbolic-ref --short HEAD)?expand=1"'
git config --global alias.recent '!~/dotfiles/git_recent.sh $*' # from https://gist.github.com/jordan-brough/48e2803c0ffa6dc2e0bd
git config --global alias.runcron '!cd ~/projects/environments; date; git pull; git add -p; git commit -m "run now"; git push; git revert HEAD; date;'
git config --global alias.pull 'pull --no-edit'
git config --global alias.runab '!run_test() {
    set -x
    git pull origin develop --no-edit
    git push
    url="https://jenkins.analytics.nymhealth.com/job/coding/job/coding_flow_a_b/job/develop/"
    test_id=""
    charts_amount="&RANDOM_CHARTS_NUMBER=0"
    parsers=""
	while getopts "t:c:p:" opt; do
		case "$opt" in
		t)  test_id="&CHOOSE_SAME_CHARTS_OF_TEST_ID="$OPTARG
            charts_amount="&RANDOM_CHARTS_NUMBER=0"
			;;
		c)  charts_amount="&RANDOM_CHARTS_NUMBER="$OPTARG
			;;
		p)  parsers="&PARSERS="$OPTARG
			;;
		esac
	done
    echo $parsers
    repo=$(basename $(git rev-parse --show-toplevel) |  tr "[:lower:]" "[:upper:]")
    curl -D - -X POST $url"/buildWithParameters?dealy=0sec&"$repo"_BRANCH="$(git symbolic-ref --short HEAD)"&SCALE=0+-+1k+charts&USE_MODELS_CACHE_DB=YES&CUSTOM_LOCAL_SERVICES=\"\"&BASELINE_CUSTOM_LOCAL_SERVICES=\"\"&TEST_TITLE="$(git symbolic-ref --short HEAD)"%20ab%20test"$test_id$charts_amount$parsers --user ehud:<token>
    # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure

    "$BROWSER" $url
}; run_test'
git config --global alias.runtest '!run_test() {
    url="https://jenkins.analytics.nymhealth.com/job/coding/job/coding_flow/job/develop/"
    test_id=""
    charts_amount="&RANDOM_CHARTS_NUMBER=0"
    parsers=""
	while getopts "t:c:p:" opt; do
		case "$opt" in
		t)  test_id="&CHOOSE_SAME_CHARTS_OF_TEST_ID="$OPTARG
            charts_amount="&RANDOM_CHARTS_NUMBER=0"
			;;
		c)  charts_amount="&RANDOM_CHARTS_NUMBER="$OPTARG
			;;
		p)  parsers="&PARSERS="$OPTARG
			;;
		esac
	done
    echo $parsers
    repo=$(basename $(git rev-parse --show-toplevel) |  tr "[:lower:]" "[:upper:]")
    curl -D - -X POST $url"/buildWithParameters?dealy=0sec&"$repo"_BRANCH="$(git symbolic-ref --short HEAD)"&SCALE=0+-+1k+charts&CUSTOM_LOCAL_SERVICES=\"\"&USE_MODELS_CACHE_DB=YES&TEST_TITLE="$(git symbolic-ref --short HEAD)"%20ab%20test"$test_id$charts_amount$parsers --user ehud:<token>
    # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure

    "$BROWSER" $url
}; run_test'
git config --global alias.runall '!run_all_tests() {
    url="https://jenkins.analytics.nymhealth.com/job/test/job/run_all_tests/job/develop/"
    repo=$(basename $(git rev-parse --show-toplevel) |  tr "[:lower:]" "[:upper:]")
    curl -D - -X POST $url"/buildWithParameters?dealy=0sec&"$repo"_BRANCH="$(git symbolic-ref --short HEAD) --user ehud:<token>
    # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure

    "$BROWSER" $url
}; run_all_tests'

export ITERM2_SQUELCH_MARK=1
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(starship init zsh)"

alias m4b-tool='docker run -it --rm -u $(id -u):$(id -g) -v "$(pwd)":/mnt m4b-tool'


alias k='kubectl'

export DEV_NAME=ehud
bindkey -e

[ -f "/Users/ehud/.ghcup/env" ] && source "/Users/ehud/.ghcup/env" # ghcup-env
alias black=black -l 160 -S -t py311

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/config/p10k-robbyrussell.zsh
# source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme
export PATH=/Library/Frameworks/Python.framework/Versions/3.11/bin/:$PATH
