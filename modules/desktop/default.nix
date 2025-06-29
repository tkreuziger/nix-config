{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # i3
    # i3status
    # picom
    # nautilus
    # dunst

    dmenu
    rofi
  ];

  # xsession.windowManager.i3 = {
  #   enable = true;
  #   extraConfig = builtins.readFile ../../dots/i3/config;
  # };

  # services.dunst = {
  #   enable = true;
  #   configFile = ../../dots/dunst/dunstrc;
  # };

  programs.rofi = {
    enable = true;
    # extraConfig = builtins.readFile ../../dots/rofi/config.rasi;
  };
}
