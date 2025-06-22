{ config, pkgs, ... }:

{
    programs = {
        kitty = {
            enable = true;
            extraConfig = builtins.readFile ../../dots/kitty/kitty.conf;
        };

        bash = {
            enable = true;
            bashrcExtra = builtins.readFile ../../dots/bash/.bashrc;
            profileExtra = builtins.readFile ../../dots/bash/.profile;
            initExtra = builtins.readFile ../../dots/bash/.bash_aliases;
        };

        starship = {
            enable = true;
            settings = builtins.fromTOML (
                builtins.readFile ../../dots/starship/starship.toml
            );
        };

        tmux = {
            enable = true;
            plugins = with pkgs.tmuxPlugins; [
                sensible
                    vim-tmux-navigator
                    yank
                    catppuccin
            ];
            extraConfig = builtins.readFile ../../dots/tmux/custom.tmux.conf;
        };

    };

}
