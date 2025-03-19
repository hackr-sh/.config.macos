{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      environment.variables = {
        ZDOTDIR = "$HOME/.config/zsh";
        XDG_CONFIG_HOME = "$HOME/.config";
      };

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          # terminals, terminal apps, and utilities
          pkgs.vim
          pkgs.starship
          pkgs.lazygit
          pkgs.atuin
          pkgs.screenfetch
          pkgs.neofetch
          pkgs.zoxide
          pkgs.fzf
          pkgs.ripgrep
          pkgs.bat
          pkgs.neovim
          pkgs.btop
          pkgs.zsh-autoenv
          pkgs.gh
          pkgs.yazi

          # apps
          # pkgs.raycast
          pkgs.mos
          # pkgs.slack
          pkgs.obsidian
          pkgs.stats
          pkgs.fontforge
          pkgs.alt-tab-macos

          # dev dependencies
          pkgs.dotnet-sdk_8
          pkgs.poetry
          pkgs.python313Full
          pkgs.go
          pkgs.asdf-vm
          pkgs.zls

          # nix stuff
          pkgs.nil
        ];
      nixpkgs.config = { allowBroken = true; allowUnfree = true; };

      # Auto upgrade nix package and the daemon service.
      nix.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh = {
        enable = true;
        enableBashCompletion = true;
        enableCompletion = true;
        enableFzfCompletion = true;
        enableFzfGit = true;
        enableFzfHistory = true;
        enableSyntaxHighlighting = true;
      };
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts._0xproto
        nerd-fonts.departure-mono
        (google-fonts.override { fonts = [ 
          "DM Sans" 
          "DM Mono" 
          "DM Serif Display" 
          "DM Sans Display"
          "Cairo"
          "Zain"
        ];})
      ];

      # Enable TouchId to authenticate sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      homebrew = {
        enable = true;
        brews = [
          "azure-cli" # we install az via brew since az ssh is broken on pkgs.azure-cli
          "mise"
          "cocoapods"
          "fastfetch"
          "nsis"
          "llvm"
          "nushell"
        ];

        masApps = {
          "Hand Mirror" = 1502839586;
          "Amphetamine" = 937984704;
          "Xcode" = 497799835;
        };

        casks = [
          "slack"
          "proton-pass"
          "proton-mail"
          "protonvpn"
          "proton-drive"
          "nikitabobko/tap/aerospace"
          "arc"
          "1password"
          "docker"
          "microsoft-outlook"
          "sip"
          "bluebubbles"
          "tableplus"
          "twingate"
          "kicad"
          "bartender"
          "jetbrains-toolbox"
          "rider"
          "visual-studio-code"
          "zed"
          "ghostty"
          "zen-browser"
          {
            name = "raycast";
            greedy = true;
          }
          "loop"
          "discord"
        ];
      };

      system.defaults = {
        ".GlobalPreferences" = {
          "com.apple.mouse.scaling" = 0.5;
          # "com.apple.mouse.linear" = true; # does not work yet
        };
        NSGlobalDomain = {
          KeyRepeat = 2;
          InitialKeyRepeat = 15;
        };

        finder = {
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          CreateDesktop = false;
        };
        dock = {
          show-recents = false;
          static-only = true;
          autohide = true;
        };
        WindowManager.StandardHideDesktopIcons = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Mohammads-MacBook-Pro
    darwinConfigurations."Mohammads-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Mohammads-MacBook-Pro".pkgs;
  };
}
