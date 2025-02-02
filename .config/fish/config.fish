if status is-interactive
    # Commands to run in interactive sessions can go here
end

## Alias
alias pn=pnpm
alias sd "cd ~ && cd (find * -type d | fzf)"
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
# alias tmux='tmux -2'

# >>> Keybinds >>>
function fish_user_key_bindings
  bind \ck 'up-or-search'
  bind \cj 'down-or-search'
  bind \ch 'backward-word'
  bind \cl 'forward-word'
end

### pnpm
set -gx PNPM_HOME "/home/Lawrence/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

### PATH
if status --is-login
    ### laravel
    set -gx path ~/.config/composer/vendor/bin:$path
    ### treesitter
    set -gx path $home/.local/bin:$path
    ### npm
    set -gx npm_config_prefix $home/.local
    ### wine prefix
    set -gx WINEPREFIX $home/.wine
end

# For fcitx5
set -gx GTK_IM_MODULE fcitx
set -gx XMODIFIERS @im=fcitx
set -gx QT_IM_MODULE fcitx

# For Manpage color
set -gx PAGER 'nvim +Man!'
set -gx EDITOR nvim
set -gx VISUAL nvim


#######################################################################
# My network config
#
# 1. Install IWD, no EnableNetworkConfiguration
# 2. Install dhcpcd
# 3. Disable SystemD-NetworkD and SystemD-ResolveD, along with services
# 4. Disable aspm or it will crash
#######################################################################
