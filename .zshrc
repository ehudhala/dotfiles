# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

ZSH_DISABLE_COMPFIX=true
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

# cd ~/projects/au
# source ~/projects/env3.11/bin/activate
# alias python="/usr/bin/python3.7"
# alias start="explorer.exe"
# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

#export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_STRATEGY=(history)
export LESS="-F -X $LESS"

# export PYTHONBREAKPOINT="IPython.embed"
export PYTHONBREAKPOINT="biscuits.tools.remote_pycharm_debug"

# export GOOGLE_APPLICATION_CREDENTIALS=/home/ehud/nym/anki/inbound-planet-201708-054c397157b0.json

# source $HOME/.poetry/env
export LDFLAGS="-L/usr/local/opt/python@3.7/lib"

poweron() {
    set -x
    aws ec2 --profile ehud start-instances --instance-ids $(aws ec2 --profile ehud describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
poweroff() {
    set -x
    aws ec2 --profile ehud stop-instances --instance-ids $(aws ec2 --profile ehud describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
powerofff() {
    set -x
    aws ec2 --profile ehud stop-instances -f --instance-ids $(aws ec2 --profile ehud describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .)
}
resize() {
    set -x
    aws ec2 --profile ehud modify-instance-attribute --instance-id $(aws ec2 --profile ehud describe-instances --filters "Name=tag:Name,Values=$1" --output json --query 'Reservations[0].Instances[0].InstanceId' | jq -r .) --instance-type "{\"Value\": \"$2\"}"
}
assh() {
        #ssh  -o "IdentitiesOnly=yes" -i ~/.ssh/aws-admin $1@$(aws ec2 describe-instances --instance-id $2 --output text --query 'Reservations[0].Instances[0].PrivateIpAddress')
        ssh  -i ~/.ssh/aws_admin_rsa -o "IdentitiesOnly=yes" $1@$(aws ec2 --profile ehud describe-instances --instance-id $2 --output text --query 'Reservations[0].Instances[0].PrivateIpAddress')
}

git config --global alias.co 'checkout'
git config --global alias.ammend 'commit --amend --no-edit'
git config --global alias.commitmb '!git commit -m $(git symbolic-ref --short HEAD)'
git config --global alias.pushu "push -u origin HEAD"
# git config --global alias.openpr '!git pushu; "$BROWSER" "https://bitbucket.org/nymhealth/$(basename `git rev-parse --show-toplevel`)/pull-requests/new?source=$(git symbolic-ref --short HEAD)"'
git config --global alias.openpr '!openpr_func() {
    git pushu

    branch_name=$(git symbolic-ref --short HEAD)

    # Find the most changed top-level directory (service/lib)
    changed_dirs=$(git diff --name-only develop...HEAD | sed "s|/.*||" | sort | uniq -c | sort -nr | head -1 | awk "{print \$2}")

    if [ -n "$changed_dirs" ]; then
        if [ "$changed_dirs" = "libs" ]; then
            # For libs, get the specific lib name
            service_name=$(git diff --name-only develop...HEAD | grep "^libs/" | sed "s|libs/||" | sed "s|/.*||" | sort | uniq -c | sort -nr | head -1 | awk "{print \$2}")
        else
            service_name="$changed_dirs"
        fi
    else
        service_name=$(basename $(git rev-parse --show-toplevel))
    fi

    # Infer PR type from branch name or commit messages
    if echo "$branch_name" | grep -qE "(fix|bug|hotfix)"; then
        pr_type="fix"
    elif echo "$branch_name" | grep -qE "(chore|refactor|cleanup)"; then
        pr_type="chore"
    else
        pr_type="feat"
    fi

    # Extract Jira ticket from branch name if present
    jira_ticket=$(echo "$branch_name" | grep -oE "CY-[0-9]+" | head -1)

    # Use branch name as summary, cleaning it up
    pr_summary=$(echo "$branch_name" | sed -E "s/^(feature|feat|fix|bug|hotfix|chore)[-_]?//i" | sed -E "s/CY-[0-9]+[-_]?//g" | sed "s/[-_]/ /g" | sed "s/^[/]*//g" | sed "s/^ *//" | sed "s/ *$//")

    if [ -z "$pr_summary" ]; then
        pr_summary="Updates from $branch_name"
    fi

    # Build title
    if [ -n "$jira_ticket" ]; then
        pr_title="$pr_type($service_name): $jira_ticket - $pr_summary"
        labels=""
    else
        pr_title="$pr_type($service_name): $pr_summary"
        labels="--label open-jira-ticket"
    fi

    gh pr create \
        --title "$pr_title" \
        --body "$(cat <<EOF
EOF
)" \
        $labels \
        --web
}; openpr_func'
git config --global alias.recent '!~/dotfiles/git_recent.sh $*' # from https://gist.github.com/jordan-brough/48e2803c0ffa6dc2e0bd
git config --global alias.runcron '!cd ~/projects/environments; date; git pull; git add -p; git commit -m "run now"; git push; git revert HEAD; date;'
git config --global alias.pull 'pull --no-edit'
git config --global alias.cpbranch '!echo $(git symbolic-ref --short HEAD) | pbcopy'
# git config --global alias.runab '!run_test() {
#     set -x
#     git pull origin develop --no-edit
#     git push
#     url="https://jenkins.analytics.nymhealth.com/job/coding/job/coding_flow_a_b/job/develop/"
#     test_id=""
#     charts_amount="&RANDOM_CHARTS_NUMBER=0"
#     parsers=""
# 	while getopts "t:c:p:" opt; do
# 		case "$opt" in
# 		t)  test_id="&CHOOSE_SAME_CHARTS_OF_TEST_ID="$OPTARG
#             charts_amount="&RANDOM_CHARTS_NUMBER=0"
# 			;;
# 		c)  charts_amount="&RANDOM_CHARTS_NUMBER="$OPTARG
# 			;;
# 		p)  parsers="&PARSERS="$OPTARG
# 			;;
# 		esac
# 	done
#     echo $parsers
#     repo=$(basename $(git rev-parse --show-toplevel) |  tr "[:lower:]" "[:upper:]")
#     curl -D - -X POST $url"/buildWithParameters?dealy=0sec&"$repo"_BRANCH="$(git symbolic-ref --short HEAD)"&SCALE=0+-+1k+charts&USE_MODELS_CACHE_DB=YES&CUSTOM_LOCAL_SERVICES=\"\"&BASELINE_CUSTOM_LOCAL_SERVICES=\"\"&TEST_TITLE="$(git symbolic-ref --short HEAD)"%20ab%20test"$test_id$charts_amount$parsers --user ehud:<token>
#     # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure
# 
#     "$BROWSER" $url
# }; run_test'
# git config --global alias.runtest '!run_test() {
#     url="https://jenkins.analytics.nymhealth.com/job/coding/job/coding_flow/job/develop/"
#     test_id=""
#     charts_amount="&RANDOM_CHARTS_NUMBER=0"
#     parsers=""
# 	while getopts "t:c:p:" opt; do
# 		case "$opt" in
# 		t)  test_id="&CHOOSE_SAME_CHARTS_OF_TEST_ID="$OPTARG
#             charts_amount="&RANDOM_CHARTS_NUMBER=0"
# 			;;
# 		c)  charts_amount="&RANDOM_CHARTS_NUMBER="$OPTARG
# 			;;
# 		p)  parsers="&PARSERS="$OPTARG
# 			;;
# 		esac
# 	done
#     echo $parsers
#     repo=$(basename $(git rev-parse --show-toplevel) |  tr "[:lower:]" "[:upper:]")
#     curl -D - -X POST $url"/buildWithParameters?dealy=0sec&"$repo"_BRANCH="$(git symbolic-ref --short HEAD)"&SCALE=0+-+1k+charts&CUSTOM_LOCAL_SERVICES=\"\"&USE_MODELS_CACHE_DB=YES&TEST_TITLE="$(git symbolic-ref --short HEAD)"%20ab%20test"$test_id$charts_amount$parsers --user ehud:<token>
#     # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure
# 
#     "$BROWSER" $url
# }; run_test'
# git config --global alias.runall '!run_all_tests() {
#     url="https://jenkins.analytics.nymhealth.com/job/test/job/run_all_tests/job/develop/"
#     repo=$(basename $(git rev-parse --show-toplevel) |  tr "[:lower:]" "[:upper:]")
#     curl -D - -X POST $url"/buildWithParameters?dealy=0sec&"$repo"_BRANCH="$(git symbolic-ref --short HEAD) --user ehud:<token>
#     # token from https://jenkins.analytics.nymhealth.com/user/<user>/configure
# 
#     "$BROWSER" $url
# }; run_all_tests'
git config --global alias.runtest '!runtest_func() {
    branch=$(git symbolic-ref --short HEAD)
    echo "Triggering E2E tests on branch: $branch"
    gh workflow run testing-e2e.yml --ref "$branch" -f skip_change_detection=true -f base_branch=develop
    echo "Waiting for workflow run to be created..."
    sleep 7
    run_url=$(gh run list --workflow="testing-e2e.yml" --branch "$branch" --limit 1 --json url --jq ".[0].url")
    if [ -n "$run_url" ]; then
        echo "Opening: $run_url"
        "$BROWSER" "$run_url"
    else
        echo "Could not find workflow run, opening workflow page instead"
        "$BROWSER" "https://github.com/cyeragit/cyera/actions/workflows/testing-e2e.yml"
    fi
}; runtest_func'

export ITERM2_SQUELCH_MARK=1
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(starship init zsh)"

alias m4b-tool='docker run -it --rm -u $(id -u):$(id -g) -v "$(pwd)":/mnt m4b-tool'

alias k='kubectl'

export DEV_NAME=ehud
bindkey -e

export LC_TIME=en_US.UTF-8

[ -f "/Users/ehud/.ghcup/env" ] && source "/Users/ehud/.ghcup/env" # ghcup-env
alias black=black -l 160 -S -t py311

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ll='ls -lGa'

# source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/config/p10k-robbyrussell.zsh
# source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme
export PATH=/Library/Frameworks/Python.framework/Versions/3.11/bin/:$PATH

. "$HOME/.local/bin/env"
# eval "$(uv generate-shell-completion zsh)"
# eval "$(uvx --generate-shell-completion zsh)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# Lazy load NVM to speed up shell startup
export NVM_DIR="$HOME/.nvm"

# Function to lazy load NVM
load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Lazy load NVM when node/npm/nvm commands are used
node() {
    unset -f node npm npx nvm lerna
    load_nvm
    node "$@"
}

npm() {
    unset -f node npm npx nvm lerna
    load_nvm
    npm "$@"
}

npx() {
    unset -f node npm npx nvm lerna
    load_nvm
    npx "$@"
}

nvm() {
    unset -f node npm npx nvm lerna
    load_nvm
    nvm "$@"
}
lerna() {
    unset -f node npm npx nvm lerna
    load_nvm
    lerna "$@"
}

# Load Cyera shared rc file from our repository:
if [ -f /Users/ehud.halamish/work/cyera/shared_rc/cyera_shared_rc.sh ]; then
    source /Users/ehud.halamish/work/cyera/shared_rc/cyera_shared_rc.sh
else
    echo "Could not find Cyera shared rc file: /Users/ehud.halamish/work/cyera/shared_rc/cyera_shared_rc.sh"
fi

if [ -f ~/cyera_run_autocomplete ]; then
    source ~/cyera_run_autocomplete
fi

# eval "$(pyenv virtualenv-init -)"  # only if you use pyenv-virtualenv

# export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# export PATH="$HOME/.pyenv/shims:$PATH"
eval "$(pyenv init -)"

export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1   # or the region where Bedrock + Claude models are enabled

alias claude="load_nvm; AWS_PROFILE=claude claude --dangerously-skip-permissions"


# Load Cyera shared rc file from our repository:
if [ -f /Users/ehud.halamish/work/cyera-fips/shared_rc/cyera_shared_rc.sh ]; then
    source /Users/ehud.halamish/work/cyera-fips/shared_rc/cyera_shared_rc.sh
else
    echo "Could not find Cyera shared rc file: /Users/ehud.halamish/work/cyera-fips/shared_rc/cyera_shared_rc.sh"
fi
ZSH_HIGHLIGHT_STYLES[comment]='none'

eval "$(~/.local/bin/mise activate zsh)"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export TMPDIR="/tmp"

# Git alias for viewing GitHub Actions failing logs
# Usage: git failinglog [pr-number|pr-url|run-id|run-url]
# If no argument provided, uses current branch
git config --global alias.cilog '!failinglog_func() {
    local input="${1:-}"
    local pr_number=""
    local run_id=""
    local branch_name=""
    local repo="cyeragit/cyera"

    # If no input, use current branch
    if [ -z "$input" ]; then
        branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [ -z "$branch_name" ]; then
            echo "Error: Not in a git repository and no input provided"
            return 1
        fi
        echo "Using current branch: $branch_name"

        # Get PR number from branch
        pr_number=$(gh pr list --head "$branch_name" --json number --jq ".[0].number" 2>/dev/null)
        if [ -z "$pr_number" ]; then
            echo "Error: No PR found for branch $branch_name"
            return 1
        fi
        echo "Found PR #$pr_number"
    else
        # Parse input to determine type
        if [[ "$input" =~ ^[0-9]+$ ]]; then
            # Pure number - could be PR or run ID
            # Try as PR first
            pr_check=$(gh pr view "$input" --json number --jq ".number" 2>/dev/null)
            if [ -n "$pr_check" ]; then
                pr_number="$input"
                branch_name=$(gh pr view "$pr_number" --json headRefName --jq ".headRefName")
                echo "Using PR #$pr_number (branch: $branch_name)"
            else
                # Treat as run ID
                run_id="$input"
                echo "Using run ID: $run_id"
            fi
        elif [[ "$input" =~ github\.com/.*/pull/([0-9]+) ]]; then
            # PR URL
            pr_number=$(echo "$input" | grep -oE "pull/[0-9]+" | grep -oE "[0-9]+")
            branch_name=$(gh pr view "$pr_number" --json headRefName --jq ".headRefName")
            echo "Using PR #$pr_number from URL (branch: $branch_name)"
        elif [[ "$input" =~ github\.com/.*/actions/runs/([0-9]+) ]]; then
            # Run URL
            run_id=$(echo "$input" | grep -oE "runs/[0-9]+" | grep -oE "[0-9]+")
            echo "Using run ID from URL: $run_id"
        else
            echo "Error: Invalid input format. Expected: PR number, PR URL, run ID, or run URL"
            return 1
        fi
    fi

    # If we have PR but no run ID, get ALL recent FAILED runs from the branch (excluding CodeQL, E2E, and Final tests)
    if [ -n "$pr_number" ] && [ -z "$run_id" ]; then
        # Find all recent failed runs, excluding CodeQL, E2E, and Final test workflows
        local run_ids=$(gh run list --branch "$branch_name" --limit 20 --json databaseId,conclusion,workflowName --jq ".[] | select(.conclusion == \"failure\" and .workflowName != \"CodeQL\" and (.workflowName | test(\"E2E|End to End|Final tests\") | not)) | .databaseId" 2>/dev/null)

        if [ -z "$run_ids" ]; then
            echo "No failed CI runs found (excluding E2E and Final tests), using latest run..."
            run_id=$(gh run list --branch "$branch_name" --limit 1 --json databaseId,workflowName --jq ".[] | select(.workflowName != \"CodeQL\" and (.workflowName | test(\"E2E|End to End|Final tests\") | not)) | .databaseId" 2>/dev/null | head -1)
        else
            echo "Found multiple failed workflow runs, downloading from all..."
            # We will process multiple run_ids
            run_id="MULTIPLE"
        fi

        if [ -z "$run_id" ] && [ -z "$run_ids" ]; then
            echo "Error: No CI runs found for branch $branch_name (PR #$pr_number)"
            return 1
        fi
    fi

    # Handle multiple workflow runs or single run
    if [ "$run_id" = "MULTIPLE" ]; then
        # Download from all failed workflows
        local log_dir="/tmp/${branch_name}-pr-${pr_number}-all-failures"
        mkdir -p "$log_dir"

        echo "Downloading from all failed workflows..."
        echo ""

        for current_run in $run_ids; do
            local wf_name=$(gh run view "$current_run" --json workflowName --jq ".workflowName" | tr " /" "_")
            echo "→ Workflow: $wf_name (run $current_run)"

            local jobs=$(gh run view "$current_run" --json jobs --jq ".jobs[] | select((.conclusion == \"failure\" or .conclusion == \"timed_out\" or .conclusion == \"cancelled\") and (.name | test(\"Final tests|Final_tests\") | not)) | {id: .databaseId, name: .name}")

            if [ -n "$jobs" ]; then
                local job_count=$(echo "$jobs" | jq -s "length")
                echo "  Found $job_count failed jobs, downloading..."

                # Save jobs to temp file to avoid subshell issues
                local jobs_file="${log_dir}/.jobs.$$.json"
                echo "$jobs" | jq -r "@json" > "$jobs_file"

                # Launch downloads and collect PIDs
                local pids=""
                while IFS= read -r job_json; do
                    local job_id=$(echo "$job_json" | jq -r ".id")
                    local job_name=$(echo "$job_json" | jq -r ".name" | tr " /" "__")
                    local log_file="${log_dir}/${wf_name}__${job_name}.log"

                    (
                        echo "  [$(date +%H:%M:%S)] Downloading: $job_name"
                        # Retry up to 3 times with exponential backoff
                        for attempt in 1 2 3; do
                            gh run view "$current_run" --log-failed --job "$job_id" > "$log_file" 2>&1
                            # Check if file is larger than 1KB (avoid empty/error files)
                            if [ -s "$log_file" ] && [ $(stat -f%z "$log_file" 2>/dev/null || stat -c%s "$log_file" 2>/dev/null) -gt 1024 ]; then
                                echo "  [$(date +%H:%M:%S)] ✓ $job_name ($(du -h "$log_file" | cut -f1))"
                                break
                            else
                                if [ $attempt -lt 3 ]; then
                                    echo "  [$(date +%H:%M:%S)] Retry $attempt for $job_name (file too small/empty)"
                                    sleep $((attempt * 2))
                                else
                                    echo "  [$(date +%H:%M:%S)] ✗ Failed: $job_name (check file manually)"
                                fi
                            fi
                        done
                    ) &
                    pids="$pids $!"

                    # Add small delay between launches to avoid overwhelming API
                    sleep 0.2
                done < "$jobs_file"

                # Wait for all downloads to complete
                echo "  Waiting for downloads to complete..."
                for pid in $pids; do
                    wait "$pid" 2>/dev/null || true
                done

                rm -f "$jobs_file"
            else
                echo "  No failed jobs found"
            fi
            echo ""
        done
    else
        # Single run - get metadata
        if [ -z "$branch_name" ]; then
            branch_name=$(gh run view "$run_id" --json headBranch --jq ".headBranch")
        fi
        if [ -z "$pr_number" ]; then
            pr_number=$(gh run view "$run_id" --json headBranch --jq ".headBranch" | xargs -I {} gh pr list --head {} --json number --jq ".[0].number" 2>/dev/null)
        fi

        local log_dir="/tmp/${branch_name}-pr-${pr_number}-run-${run_id}"

        if [ -d "$log_dir" ] && [ "$(ls -A "$log_dir" 2>/dev/null)" ]; then
            echo "Logs already downloaded in: $log_dir"
        else
            echo "Downloading logs to: $log_dir"
            mkdir -p "$log_dir"

            local jobs=$(gh run view "$run_id" --json jobs --jq ".jobs[] | select((.conclusion == \"failure\" or .conclusion == \"timed_out\" or .conclusion == \"cancelled\") and (.name | test(\"Final tests|Final_tests\") | not)) | {id: .databaseId, name: .name}")

            if [ -z "$jobs" ]; then
                echo "No failed jobs found"
                return 1
            fi

            echo ""
            echo "Downloading logs in parallel..."
            echo ""

            # Save jobs to temp file to avoid subshell issues
            local jobs_file="${log_dir}/.jobs.$$.json"
            echo "$jobs" | jq -r "@json" > "$jobs_file"

            local pids=""
            while IFS= read -r job_json; do
                local job_id=$(echo "$job_json" | jq -r ".id")
                local job_name=$(echo "$job_json" | jq -r ".name" | tr " /" "__")
                local log_file="${log_dir}/${job_name}.log"

                (
                    echo "[$(date +%H:%M:%S)] Downloading: $job_name"
                    for attempt in 1 2 3; do
                        gh run view "$run_id" --log-failed --job "$job_id" > "$log_file" 2>&1
                        if [ -s "$log_file" ] && [ $(stat -f%z "$log_file" 2>/dev/null || stat -c%s "$log_file" 2>/dev/null) -gt 1024 ]; then
                            echo "[$(date +%H:%M:%S)] ✓ $job_name ($(du -h "$log_file" | cut -f1))"
                            break
                        else
                            if [ $attempt -lt 3 ]; then
                                echo "[$(date +%H:%M:%S)] Retry $attempt for $job_name"
                                sleep $((attempt * 2))
                            else
                                echo "[$(date +%H:%M:%S)] ✗ Failed: $job_name"
                            fi
                        fi
                    done
                ) &
                pids="$pids $!"
                sleep 0.2
            done < "$jobs_file"

            echo "Waiting for downloads to complete..."
            for pid in $pids; do
                wait "$pid" 2>/dev/null || true
            done
            rm -f "$jobs_file"
            echo ""
        fi
    fi

    echo "✓ All downloads complete!"

    # List directory
    echo ""
    echo "Log files in $log_dir:"
    ls -lah "$log_dir"

    # Open logs in vim with ANSI color support
    echo ""
    echo "✓ Logs ready! Opening in vim..."
    echo "Tip: Use gt/gT to switch between tabs, :q to quit"
    echo ""

    vim -p "$log_dir"/*.log \
        -c "tabdo set nowrap | tabdo set nonumber | tabdo colorscheme default" \
        -c "highlight clear TabLine | highlight clear TabLineSel | highlight clear TabLineFill" \
        -c "highlight TabLineFill ctermfg=NONE ctermbg=Black | highlight TabLine ctermfg=Cyan ctermbg=Black cterm=NONE | highlight TabLineSel ctermfg=Black ctermbg=Cyan cterm=bold" \
        -c "tabdo AnsiEsc" \
        -c "tabfirst"
}; failinglog_func'
