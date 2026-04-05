{ config, pkgs, ... }:

{
  home.username = "vscode";
  home.homeDirectory = "/home/vscode";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nixfmt-rfc-style
    pkg-config
    openssl
    git
    fd
    ripgrep
    bacon
  ];

  programs.bash.enable = true;

  home.sessionVariables = {
    EDITOR = "code";
  };
}