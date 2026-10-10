{ pkgs, username, ... }:

{
  homebrew = {
    enable = true;

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
      "yandex-cloud-cli"
      "zoom"
    ];

    global.autoUpdate = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  system.primaryUser = "${username}";

  system.stateVersion = 7; # Don't change it

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };
}
