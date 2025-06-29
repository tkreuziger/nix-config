{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    which

    fd
    ripgrep
    fzf
    eza
    bat
    delta
    yazi

    pass

    tdf
    flameshot
    haskellPackages.greenclip
  ];

  services.flameshot.enable = true;
  xdg.configFile."flameshot/flameshot.ini".source = ../../dots/flameshot/flameshot.ini;

  xdg.configFile."greenclip.toml".source = ../../dots/greenclip/greenclip.toml;
}
