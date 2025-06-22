{ config, pkgs, ... }:

{
    home = {
      packages = with pkgs; [
        steam
        protonup-ng
        lutris
        gamemode
        mangohud
        wineWowPackages.staging
        winetricks
      ];

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
        MANGOHUD = "1";
      };
    };

}
