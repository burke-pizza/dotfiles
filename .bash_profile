# $ brew ls
# ==> Formulae
# drone			go			libvterm		msgpack			openssl@1.1		python@3.9		the_silver_searcher
# gdbm			jq			libyaml			neovim			pcre			readline		unibilium
# gettext		libtermkey		lua			nvm			pcre2			ruby			vim
# git			libuv			luajit			oniguruma		perl			sqlite			xz
#
# ==> Casks
# dropbox			font-source-code-pro	rectangle
# [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM

# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.sh ] && source ~/.fzf.sh
#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

git config --global alias.grog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global pull.rebase false

source ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export GOROOT="$HOME/go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin"
