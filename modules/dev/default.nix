{
  config,
  pkgs,
  ...
}: {
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
  home.file."catppuccin.gitconfig".source = ../../dots/git/catppuccin.gitconfig;

  home.file.".config/bat/themes/Catppuccin Mocha.tmTheme".source = ../../dots/bat/${"Catppuccin Mocha.tmTheme"};

  home.file.".config/lazygit/config.yml".source = ../../dots/lazygit/config.yml;
}
