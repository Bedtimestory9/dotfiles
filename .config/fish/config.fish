fish_vi_key_bindings
## Alias
alias sd "nvim (find ~/Documents -type f | fzf)"
alias pd "cd (find ~/Projects -type d | fzf)"
alias v nvim

## git
alias gs "git status"
alias gco "git checkout"
alias gw "git switch"
alias gap "git add -p"
## proxy
alias s5 "env {http,https}_proxy=socks5://127.0.0.1:8118"

# Dotfiles manipulation
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

set fish_greeting

fish_config theme choose flexoki-dark
# >>> Keybinds >>>
# function fish_user_key_bindings
#     bind \ck up-or-search
#     bind \cj down-or-search
#     bind \ch backward-word
#     bind \cl forward-word
#     ### Auto-suggestion
#     bind \cw accept-autosuggestion
#     bind \cd backward-kill-bigword
# end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function gitlogue-menu
    set choice (printf "Random commits\nSpecific commit\nBy author\nBy date range\nTheme selection" \
        | fzf --prompt="gitlogue> " --height=40% --reverse)

    switch "$choice"
        case "Random commits"
            gitlogue

        case "Specific commit"
            set commit (git log --oneline | fzf --prompt="Select commit> " | awk '{print $1}')
            if test -n "$commit"
                gitlogue --commit "$commit"
            end

        case "By author"
            set author (git log --format='%an' | sort -u | fzf --prompt="Select author> ")
            if test -n "$author"
                gitlogue
            end

        case "Theme selection"
            set theme (gitlogue theme list | tail -n +2 | sed 's/^  - //' | fzf --prompt="Select theme> ")
            if test -n "$theme"
                gitlogue --theme "$theme"
            end
    end
end

# Expo
set -x ANDROID_HOME /opt/android-sdk/
set -x ANDROID_SDK_ROOT /opt/android-sdk/

# React Native
set -x HOME /Users/lawrence

# npm
set -x npm_config_prefix "$HOME/.local"

# postgresql
set fish_user_paths /usr/local/opt/postgresql@18/bin

# fcitx5
# set -Ux GTK_IM_MODULE fcitx
# set -Ux XMODIFIERS @im=fcitx
# set -Ux QT_IM_MODULE fcitx
# set -Ux SDL_IM_MODULE fcitx

# manpage color
set -x PAGER less
set -x EDITOR nvim
set -x VISUAL nvim

# pnpm
set -x PNPM_HOME "/home/Lawrence/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -x PATH "$PNPM_HOME" $PATH
end

# Elixir
## enable history
set -x ERL_AFLAGS "-kernel shell_history enabled"
## Weird mix_env
set -x MIX_ENV dev

# Ruby
fish_add_path /usr/local/opt/ruby/bin
## for local gem
set GEM_HOME $HOME/.gem
fish_add_path $GEM_HOME/bin
## for compiler to find ruby
set -gx LDFLAGS -L/usr/local/opt/ruby/lib
set -gx CPPFLAGS -I/usr/local/opt/ruby/include
## for config
set -gx PKG_CONFIG_PATH /usr/local/opt/ruby/lib/pkgconfig
## for cocoapods, can check from `gem which cocoapods`, not at the cocoapods/bin tho
# (FUCKING COCOAPODS YOU POS #$@##@#)
fish_add_path /Users/lawrence/.gem/ruby/3.4.0/bin

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
