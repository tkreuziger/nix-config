{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vlc
    spotify
  ];
}
