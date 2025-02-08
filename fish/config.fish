# add all additional paths to fish_user_paths
for p in \
    /run/current-system/sw/bin \
    ~/bin \
    ~/.local/bin \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    ~/.spicetify \
    ~/.dotnet/tools \
    ~/.orbstack/bin
    if not contains $p $fish_user_paths
        set -g fish_user_paths $p $fish_user_paths
    end
end

export ANDROID_HOME="/Users/hackr/Library/Android/sdk"

# # init various fish plugins
atuin init fish | source
zoxide init fish | source
starship init fish | source
fzf --fish | source
/opt/homebrew/bin/mise activate fish | source

# aliases
alias rebuild="darwin-rebuild switch --flake ~/.config/nix-darwin"
alias rebuild-upgrade="darwin-rebuild switch --flake ~/.config/nix-darwin --upgrade"
alias rebuild-custom="darwin-rebuild switch --flake ~/.config/nix-darwin -I darwin=~/dev/nix-darwin"
alias pip="python3 -m pip"
alias g="git"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias cl="clear; fastfetch"
alias l="ls -lah"
alias ghostty="/Applications/Ghostty.app/Contents/MacOS/ghostty"
alias b="bun"
abbr -a -- - "z -"