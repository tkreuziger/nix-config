{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        git
        lazygit

        gcc
        gnumake
        nodejs
        nodePackages.npm
        cargo
        rustc
        go
        uv
    ];

    home.file.".gitconfig".source = ../../dots/git/.gitconfig;
    home.file.".gitignore_global".source = ../../dots/git/.gitignore_global;
}
