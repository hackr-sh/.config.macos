# ⚠️ This project is now archived ⚠️
> Further maintenance of hackr's darwin configs can be found at https://github.com/hackr-sh/hackr-nixos

## hackr's nix-darwin dotfiles

### Installation

1. Install nix [here](https://nixos.org/download.html)
2. Install nix-darwin (via the flakes section) [here](https://github.com/LnL7/nix-darwin?tab=readme-ov-file#flakes)
3. Clone this repo to ~/.config
4. Run `darwin-rebuild switch --flake ~/.config/nix-darwin`
5. You probably need to change a couple more things that cannot be contained within the flake - when I remember them I'll add them here:
  - Change the `nixpkgs.hostPlatform` to your system's platform
  - Change the wallpapers for each monitor
  - Setup various apps manually (i.e. 1password for the ssh agent, discord, spotify, etc.)
  - install [brew](https://brew.sh/) (like why is this a thing?)
