## Alias
alias sd "nvim (find ~/Documents -type f | fzf)"
alias pd "cd (find ~/Projects -type d | fzf)"
alias y "yazi"
alias v "nvim"

## git
alias gs "git status"
alias gco "git checkout"
alias gap "git add -p"
alias gdf "git diff --"
alias s5 "env {http,https}_proxy=socks5://127.0.0.1:1080"

# Dotfiles manipulation
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

set fish_greeting

fish_config theme choose flexoki-dark
# >>> Keybinds >>>
function fish_user_key_bindings
    bind \ck 'up-or-search'
    bind \cj 'down-or-search'
    bind \ch 'backward-word'
    bind \cl 'forward-word'
    ### Auto-suggestion
    bind \cw accept-autosuggestion
    bind \cd backward-kill-bigword
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
	    builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

### For Expo
set -Ux ANDROID_HOME "/opt/android-sdk/"
set -Ux ANDROID_SDK_ROOT "/opt/android-sdk/"

### npm
set -Ux npm_config_prefix "$HOME/.local"

# For fcitx5
set -Ux GTK_IM_MODULE fcitx
set -Ux XMODIFIERS @im=fcitx
set -Ux QT_IM_MODULE fcitx
set -Ux SDL_IM_MODULE fcitx
# set -gx GLFW_IM_MODULE ibus

# For Manpage color
set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim

# set -gx http_proxy socks5://127.0.0.1:1080
# set -gx https_proxy $http_proxy
# set -gx ftp_proxy $http_proxy
# set -gx rsync_proxy $http_proxy
# set -gx no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"

# pnpm
set -Ux PNPM_HOME "/home/Lawrence/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -Ux PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Elixir
# enable history
set -x ERL_AFLAGS "-kernel shell_history enabled"
### Weird mix_env
set -x MIX_ENV dev

# Tips:
# If you are looking for why /cj doesn't work is because of fish tide, you can't do the compact style
# WARN: Don't do this `set PATH $PATH:/home/Lawrence/.local/bin`, it causes a massive slow
