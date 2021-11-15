#! /bin/bash

# ==> Formulae
# apr     coreutils   icu4c     libtermkey    lz4     node      python@3.9    unibilium
# apr-util    fnm     jemalloc    libtool     m4      nvm     readline    utf8proc
# autoconf    fzf     jq      libuv     mpdecimal   oniguruma   sqlite      xz
# automake    gdbm      libev     libvterm    msgpack     openssl@1.1   subversion    zlib
# awscli      gettext     libevent    libyaml     ncurses     pcre      the_silver_searcher
# brotli      git     libgpg-error    luajit-openresty  neovim      pcre2     tmux
# c-ares      hugo      libksba     luv     nghttp2     pkg-config    tree-sitter
#
# ==> Casks
# font-source-code-pro  macfuse     ngrok     rectangle

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask iterm2 && \
brew install coreutils && \
brew install node && \
brew install fnm && \
brew install jq && \
brew install the_silver_searcher && \
brew install git && \
brew install fzf && \
brew install neovim --head \
brew install awscli && \
brew install --cask rectangle && \
brew install --cask ngrok && \
brew install --cask proxyman && \
git clone https://github.com/adobe-fonts/source-code-pro ~/Downloads/source-code-pro && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
