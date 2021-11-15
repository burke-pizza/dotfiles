[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ~/.bash_profile

git config --global alias.grog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global pull.rebase false

export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
eval "$(fnm env)"

if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag --hidden -p ~/.gitignore -g ""'
fi

# turn on git autocomplete
autoload -Uz compinit && compinit

export PROMPT=': %0~ ; '

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export PATH="$PATH:$HOME/go/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
