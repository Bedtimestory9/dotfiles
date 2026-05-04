set fish_greeting
fish_vi_key_bindings

## Alias
alias pd 'cd (find ~/Projects -type d -maxdepth 2 | fzf)'
alias v nvim

## git
alias gs "git status -sb"
alias gco "git checkout"
alias gw "git switch"
alias gap "git add -p"

## proxy
alias s5='env http_proxy=socks5h://127.0.0.1:10800 https_proxy=socks5h://127.0.0.1:10800'

# Dotfiles manipulation
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

fish_config theme choose Lava

## Yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

fish_add_path /usr/local/opt/trash-cli/bin
##

# Expo
set -x ANDROID_HOME /opt/android-sdk/
set -x ANDROID_SDK_ROOT /opt/android-sdk/

# npm
set -x npm_config_prefix $HOME/.local
fish_add_path $HOME/.local/bin

# pnpm
set -x PNPM_HOME $HOME/.local/share/pnpm/
fish_add_path $PNPM_HOME

# postgresql
fish_add_path /usr/local/opt/postgresql@18/bin

# fcitx5
# set -Ux GTK_IM_MODULE fcitx
# set -Ux XMODIFIERS @im=fcitx
# set -Ux QT_IM_MODULE fcitx
# set -Ux SDL_IM_MODULE fcitx

## Golang
set -x GOPATH $HOME/.go
fish_add_path $GOPATH/bin

# manpage color
set -x PAGER less
set -x EDITOR nvim
set -x VISUAL nvim

# Elixir
## enable history
set -x ERL_AFLAGS "-kernel shell_history enabled"
## Weird mix_env
set -x MIX_ENV dev

# Ruby
## for local gem
set GEM_HOME $HOME/.gem
fish_add_path $GEM_HOME/bin
## for compiler to find ruby
set -x LDFLAGS -L/usr/local/opt/ruby/lib
set -x CPPFLAGS -I/usr/local/opt/ruby/include
## for config
set -x PKG_CONFIG_PATH /usr/local/opt/ruby/lib/pkgconfig
## for cocoapods, can check from `gem which cocoapods`, not at the cocoapods/bin tho
# (FUCKING COCOAPODS YOU POS #$@##@#)
fish_add_path $GEM_HOME/ruby/3.4.0/bin

## Clang
fish_add_path /usr/local/opt/llvm/bin
# For compilers to find llvm you may need to set:
set -gx LDFLAGS -L/usr/local/opt/llvm/lib
set -gx CPPFLAGS -I/usr/local/opt/llvm/include
#For cmake to find llvm you may need to set:
set -gx CMAKE_PREFIX_PATH /usr/local/opt/llvm

# Java
# set -x JAVA_17_HOME /usr/local/Cellar/openjdk@17/17.0.17/libexec/openjdk.jdk/Contents/Home
# set -x JAVA_21_HOME /usr/local/Cellar/openjdk@21/21.0.9/libexec/openjdk.jdk/Contents/Home
# Default Java 17
# set -x JAVA_HOME $JAVA_17_HOME
# set -x PATH $JAVA_HOME/bin $PATH

# alias java17 "set -x JAVA_HOME $JAVA_17_HOME; echo JAVA_HOME switched to Java 17"
# alias java21 "set -x JAVA_HOME $JAVA_21_HOME; echo JAVA_HOME switched to Java 21"

# Tips:
# If you are looking for why /cj doesn't work is because of fish tide, you can't do the compact style

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
