{ pkgs, stateVersionDarwin, username, ... }:

{
  homebrew = {
    enable = true;

    brews = [
      "mas"
    ];

    casks = [
      "clipy"
      "discord"
      "docker-desktop"
      "element"
      "firefox"
      "gnucash"
      "google-chrome"
      "iterm2"
      "ledger-wallet"
      "microsoft-auto-update"
      "microsoft-teams"
      "obsidian"
      "pritunl"
      "spotify"
      "telegram"
      "utm"
      "virtualbox"
      "vscodium"
      "zoom"
    ];

    masApps = {
      "Numbers" = 361304891;
      "Pages" = 361309726;
      "Windows App" = 1295203466;
    };

    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  system.primaryUser = "${username}";

  system.stateVersion = stateVersionDarwin;

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };
}
