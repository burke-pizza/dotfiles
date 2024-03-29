# https://github.com/junegunn/fzf
# brew install fzf
# To install useful key bindings and fuzzy completion:
# $(brew --prefix)/opt/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ~/.bash_profile

git config --global user.email kburke@peaksware.com
# automatic --set-upstream on git push if there isn't a matching remote branch.
git config --global push.autoSetupRemote true

# git grog is fun to show off, and useful when you want to visually scan a large
# number of messily connected branches.
git config --global alias.grog 'log --graph --abbrev-commit --decorate --all --first-parent --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global pull.rebase false

# https://github.com/Schniz/fnm
# curl -fsSL https://fnm.vercel.app/install | bash
eval "$(fnm env)"

# Set fzf to use ag (the_silver_searcher) by default, and use the global
# .gitignore.
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag --hidden -p ~/.gitignore -g ""'
fi

function zvm_config() {
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}

# https://github.com/jeffreytse/zsh-vi-mode
# brew install zsh-vi-mode
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Git autocomplete.
autoload -Uz compinit && compinit

# simple prompt that just shows PWD relative to $HOME (~). wrapping the prompt
# in : and ; means you can copy the entire line (colon, in shell-speak, means
# "ignore everything after this", and semicolon means "the end of everything
# before this")
export PROMPT=': %0~ ; '

## adding Homebrew-installed things to the $PATH.
# gnu coreutils are all prefixed by g (gcat, gtime). gawk isn't there for some
# reason?
export PATH="/opt/homebrew/opt/coreutils/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
alias composer="/opt/homebrew/bin/composer"
alias php="/opt/homebrew/bin/php"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"


# Add .NET Core SDK tools
export PATH="/Users/kburke/.dotnet/tools:$PATH"
# export PATH="/usr/local/share/dotnet/x64/dotnet:$PATH"

# Stripe CLI autocomplete
fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i

export DOTNET_ROOT="/usr/local/share/dotnet"

eval $(thefuck --alias)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export AWS_SHARED_CREDENTIALS_FILE=${HOME}/.aws/local-aws-credentials
export AWS_PROFILE=dev
