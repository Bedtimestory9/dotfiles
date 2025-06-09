if status is-interactive
    # Commands to run in interactive sessions can go here
end

## Alias
alias sd "cd (find . -type d | fzf)"
alias y "yazi"
alias v "nvim"
alias s5 "proxy-ns"
alias pnpx "pnpm exec"

alias gs "git status"
alias gco "git checkout"
alias gap "git add -p"

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
set -Ux CMAKE_POLICY_VERSION_MINIMUM 3.5
set -Ux LOWER /opt/android-sdk
set -Ux UPPER "$HOME/.local/android/.sdk/upper"
set -Ux WORK "$HOME/.local/android/.sdk/work"
set -Ux ANDROID_HOME "$HOME/.local/android/sdk"
set -Ux ANDROID_SDK_ROOT "$HOME/.local/android/sdk"
set -Ux PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools
# set -x QT_QPA_PLATFORM "xcb"

# Then mount your overlay and export the Android home variable:

#$ fuse-overlayfs -o squash_to_uid=$(id -u),squash_to_gid=$(id -g),lowerdir=$LOWER,upperdir=$UPPER,workdir=$WORK $ANDROID_HOME
#$ export ANDROID_HOME

# You can now use any Android tool (`sdk-manager` for instance) with your copy-on-write setup.
# You can unmount it as with any other FUSE fs:

#$ fusermount -u $ANDROID_HOME

### treesitter
fish_add_path $HOME/.local/bin
### npm
set -x npm_config_prefix "$HOME/.local"
### Weird mix_env
set -x MIX_ENV dev

# For fcitx5
set -gx GTK_IM_MODULE fcitx
set -gx XMODIFIERS @im=fcitx
set -gx QT_IM_MODULE fcitx

# For Manpage color
set -gx PAGER 'nvim +Man!'
set -gx EDITOR nvim
set -gx VISUAL nvim

# set -gx http_proxy socks5://127.0.0.1:1080
# set -gx https_proxy $http_proxy
# set -gx ftp_proxy $http_proxy
# set -gx rsync_proxy $http_proxy
# set -gx no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"

# If you are looking for why /cj doesn't work is because of fish tide, you can't do the compact style
# If you are systemctl authenticating as: root, add your user to the wheel group

# pnpm
set -gx PNPM_HOME "/home/Lawrence/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
