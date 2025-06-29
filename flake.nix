{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixgl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "tristan";
  in {
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nixgl.overlay
          (final: prev: {
            dmenu = prev.stdenv.mkDerivation rec {
              pname = "dmenu-flexipatch";
              version = "5.3-20241115";

              src = prev.fetchFromGitHub {
                owner = "bakkeby";
                repo = "dmenu-flexipatch";
                rev = "master";
                sha256 = "sha256-vV4SkxUcq8fzTZQrMtas720kA6thhJ1/kFM0/On1MQU=";
              };

              buildInputs = with prev; [
                xorg.libX11
                xorg.libXft
                xorg.libXinerama
                fontconfig
              ];
              nativeBuildInputs = with prev; [pkg-config];

              postPatch = ''
                # Copy the default patches configuration
                cp patches.def.h patches.h

                # Enable XYW patch
                sed -i 's/#define XYW_PATCH 0/#define XYW_PATCH 1/' patches.h
                sed -i 's/#define CENTER_PATCH 0/#define CENTER_PATCH 1/' patches.h
                sed -i 's/#define CTRL_V_TO_PASTE_PATCH 0/#define CTRL_V_TO_PASTE_PATCH 1/' patches.h
                sed -i 's/#define FUZZYMATCH_PATCH 0/#define FUZZYMATCH_PATCH 1/' patches.h
                sed -i 's/#define HIGHLIGHT_PATCH 0/#define HIGHLIGHT_PATCH 1/' patches.h
              '';

              makeFlags = ["PREFIX=$(out)"];

              meta = with prev.lib; {
                description = "dmenu with flexipatch - includes xyw and many other patches";
                homepage = "https://github.com/bakkeby/dmenu-flexipatch";
                license = licenses.mit;
                platforms = platforms.all;
              };
            };
          })
        ];
        config = {
          allowUnfree = true;
        };
      };

      modules = [
        ./home.nix
      ];
    };
  };
}
