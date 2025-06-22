{ config, pkgs, ... }:

{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        (nerdfonts.override {
         fonts = [
         "FiraCode"
         "JetBrainsMono"
         "SauceCodePro"
         "Hack"
         ];
         })
    ];

    xdg.configFile."fontconfig/fonts.conf".source = ../../dots/fontconfig/fonts.conf;
}
