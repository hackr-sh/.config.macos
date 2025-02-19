exec /opt/homebrew/bin/nu
return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$ZDOTDIR/ohmyzsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  1password
  asdf
  macos
  zoxide
  zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/cyberpunk_neon.zsh-theme


# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=50000
SAVEHIST=50000
setopt autocd extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/hackr/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

###############################################################################
# ENVIRONMENT VARIABLES                                                       #
###############################################################################

export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/opt/homebrew/sbin"
export PATH="$PATH:/Users/hackr/.asdf/shims"
export NVM_DIR="$HOME/.nvm"
export ZDOTDIR="$HOME/.config/zsh"
export KEEP_ZSHRC="yes"

###############################################################################
# EVALUATION FUNCTIONS AND LOADERS                                            #
###############################################################################

eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

###############################################################################
# ALIASES AND FUNCTIONS                                                       #
###############################################################################

alias rebuild="darwin-rebuild switch --flake ~/.config/nix-darwin"
alias rebuild-custom="darwin-rebuild switch --flake ~/.config/nix-darwin -I darwin=~/dev/nix-darwin"
alias pip="python3 -m pip"
alias g="git"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias cl="clear"
alias l="ls -lah"
alias ghostty="/Applications/Ghostty.app/Contents/MacOS/ghostty"
alias b="bun"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
eval "$(/opt/homebrew/bin/mise activate zsh)"

export PATH=$PATH:/Users/hackr/.spicetify
