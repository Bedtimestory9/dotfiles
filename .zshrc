# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Mundane stuff
export EDITOR='nvim'
export VISUAL='nvim'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v="nvim"
alias pd='cd "$(find ~/Projects -type d | fzf)"'
alias s5="env {http,https}_proxy=socks5://127.0.0.1:1080"
alias ..="cd .."

# Auto-suggestion
export ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history )

# KEYBINDS

# Search
bindkey "^K" up-line-or-history
bindkey "^J" down-line-or-history
bindkey "^H" backward-word
bindkey "^L" forward-word
# Auto-suggestion (only work with the plugin)
bindkey "^W" autosuggest-accept
bindkey "^D" backward-kill-word

# Yazi 'cd' mode
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Android Development
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
# IOS Development
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# To activate the autosuggestions, add the following at the end of your .zshrc:
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Theme powerlevel10k
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Substring search
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# Ruby MacOS
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.7
