{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "tristan";
  homeDirectory = "/home/${username}";
in {
  imports = [
    ./modules/desktop
    ./modules/terminal
    ./modules/dev
    ./modules/tools
    ./modules/media
    ./modules/gaming
    ./modules/theme
  ];

  home = {
    username = username;
    homeDirectory = lib.mkDefault homeDirectory;

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.nixgl.nixGLIntel
  ];

  home.file.".local/bin/bat_preview".source = ./dots/bash/bat_preview;
  home.file.".local/bin/tmux_helper".source = ./dots/bash/tmux_helper;

  nixpkgs.config.allowUnfree = true;
}
