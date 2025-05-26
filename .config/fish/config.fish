if status is-interactive
    # Commands to run in interactive sessions can go here
end

## Alias
alias sd "cd (find . -type d | fzf)"
alias y "yazi"
alias v "nvim"

# Dotfiles manipulation
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

fish_config theme choose Tomorrow\ Night\ Bright
# >>> Keybinds >>>
function fish_user_key_bindings
    bind \ck 'up-or-search'
    bind \cj 'down-or-search'
    bind \ch 'backward-word'
    bind \cl 'forward-word'
    ### Auto-suggestion
    bind \cd accept-autosuggestion
    bind \cw backward-kill-bigword
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

### treesitter
fish_add_path $home/.local/bin
### npm
set -gx npm_config_prefix "$home/.local"
### wine prefix
set -gx WINEPREFIX "$home/.wine"
### Weird mix_env
set -gx MIX_ENV dev

# For fcitx5
set -gx GTK_IM_MODULE fcitx
set -gx XMODIFIERS @im=fcitx
set -gx QT_IM_MODULE fcitx

# For Manpage color
set -gx PAGER 'nvim +Man!'
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx __NV_PRIME_RENDER_OFFLOAD 1 
set -gx __GLX_VENDOR_LIBRARY_NAME 'nvidia command'

#set -gx http_proxy http://127.0.0.1:1080/
#set -gx https_proxy $http_proxy
#set -gx ftp_proxy $http_proxy
#set -gx rsync_proxy $http_proxy
#set -gx no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"

#######################################################################
# My network config
#
# 1. Install IWD, no EnableNetworkConfiguration
# 2. Install dhcpcd
# 3. Disable SystemD-NetworkD and SystemD-ResolveD, along with services
# 4. Disable aspm or it will crash

# If you are looking for why /cj doesn't work is because of fish tide, you can't do the compact style
#######################################################################
