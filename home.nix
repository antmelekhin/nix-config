{ config, homeStateVersion, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnutar
    go
    hadolint
    jq
    k9s
    kubectl
    kubernetes-helm
    nmap
    packer
    powershell
    pre-commit
    python312
    python314Packages.tox
    python314Packages.virtualenv
    qemu
    terraform
    terraform-docs
    terragrunt
    tflint
    tfsec
    tree
    vagrant
    wget
    wireguard-tools
  ];

  home.sessionVariables = {
    CLICOLOR = 1;
  };

  home.stateVersion = "${homeStateVersion}";

  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      kubeconfig() {
        export KUBECONFIG="$(
          find "${config.home.homeDirectory}/.kube" \
            -type f \
            \( -name "config" -o -name "*.yaml" -o -name "*.yml" \) \
            -print \
            | sort \
            | paste -sd: -
        )"
      }

      kubeconfig
    '';

    shellAliases = {
      ll = "ls -lh";
      la = "ls -ahl";
      gs = "git status";
    };
  };

  targets.darwin.copyApps.directory = "Applications";
}
