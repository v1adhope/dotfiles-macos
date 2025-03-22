{
  description = "v1adhope nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, mac-app-util }:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
	      neovim
        tmux
	      alacritty
        lazygit
        kafkactl
        go-task

        glow
        ripgrep
        fzf
        ruff
        gotools
        stylua

	      go
	      rustup
        nodejs
        dotnetCorePackages.dotnet_8.sdk
        dotnetCorePackages.dotnet_8.aspnetcore
        dotnetCorePackages.dotnet_8.runtime
        dotnet-sdk_7
        dotnet-aspnetcore_7
        dotnet-runtime_7
        dotnet-sdk_6
        dotnet-aspnetcore_6
        dotnet-runtime_6
        mono
	      android-tools

        skimpdf
	      telegram-desktop
      ];

      fonts.packages = with pkgs; [ nerd-fonts.hack ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh = {
        enable = true;
        enableBashCompletion = true;
        enableCompletion = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # See https://mynixos.com/nix-darwin/options/system.defaults
      system.defaults = {
        dock.autohide = true;
        dock.show-recents = false;
        dock.wvous-br-corner = 13;
        finder.AppleShowAllExtensions = true;
        finder.AppleShowAllFiles = true;
        finder.FXPreferredViewStyle = "clmv";
        finder.FXRemoveOldTrashItems = true;
        finder.NewWindowTarget = "OS volume";
        finder.QuitMenuItem = true;
        finder.ShowExternalHardDrivesOnDesktop = false;
        finder.ShowHardDrivesOnDesktop = false;
        finder.ShowMountedServersOnDesktop = false;
        finder.ShowRemovableMediaOnDesktop = false;
        hitoolbox.AppleFnUsageType = "Do Nothing";
        menuExtraClock.ShowSeconds = true;
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
        trackpad.Clicking = true;
        WindowManager.StandardHideWidgets = true;
        NSGlobalDomain."com.apple.keyboard.fnState" = true;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
        NSGlobalDomain."com.apple.swipescrolldirection" = true;
        NSGlobalDomain."com.apple.trackpad.scaling" = 2.5;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
        NSGlobalDomain.AppleMetricUnits = 1;
        NSGlobalDomain.AppleShowScrollBars = "Always";
        NSGlobalDomain.AppleTemperatureUnit = "Celsius";
	      dock.persistent-apps = [
	        "/Applications/KeePassium.app"
	        "/Applications/Obsidian.app"
          "${pkgs.skimpdf}/Applications/Skim.app"
	        "/Applications/Firefox.app"
          "${pkgs.telegram-desktop}/Applications/Telegram.app"
          "/Applications/Slack.app"
          "/Applications/Mattermost.app"
	        "/Applications/Insomnia.app"
          "/Applications/Rider.app"
          "/Applications/DataGrip.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Zed.app"
	        "${pkgs.alacritty}/Applications/Alacritty.app"
	        "/System/Applications/System Settings.app"
	      ];
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowInsecurePackages = true;

      nixpkgs.hostPlatform = "aarch64-darwin";

      nixpkgs.config.permittedInsecurePackages = [
        "dotnet-sdk-7.0.410"
        "aspnetcore-runtime-7.0.20"
        "dotnet-runtime-7.0.20"
        "dotnet-sdk-6.0.428"
        "aspnetcore-runtime-6.0.36"
        "dotnet-runtime-6.0.36"
      ];

      homebrew = {
      	enable = true;
        taps = [
          "nikitabobko/tap"
        ];
	      casks = [
          "nikitabobko/tap/aerospace"
          "maccy"
          "raycast"
          "shottr"

	        "docker"
	        "openvpn-connect"
	        "insomnia"
          "zed"
          "visual-studio-code"
          "datagrip"
          "rider"
          "windows-app"

          "obsidian"
	        "firefox"
	        "dropbox"
          "keka"
          "appcleaner"
          "monitorcontrol"

          "slack"
          "mattermost"
	      ];
        brews = [
          "mkcert"
          "libpq"
        ];
	      masApps = {
          "Numbers" = 409203825;
          "Keynote" = 409183694;
          "Pages" = 409201541;
          "KeePassium" = 1435127111;
        };
	      onActivation.cleanup = "zap";
	      onActivation.autoUpdate = true;
	      onActivation.upgrade = true;
    };
  };
  in
  {
    darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
	      nix-homebrew.darwinModules.nix-homebrew
	      {
	        nix-homebrew = {
	          enable = true;
	          enableRosetta = true;
	          user = "rat";
	        };
	      }
	      mac-app-util.darwinModules.default
      ];
    };
  };
}
