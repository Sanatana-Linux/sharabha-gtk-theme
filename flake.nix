{
  description = "Sharabha GTK Theme — A skeuomorphic GTK theme based on the Sanatana Linux color palette";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      themeName = "Sharabha-GTK";
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "sharabha-gtk-theme";
        version = "1.0.0";

        src = ./.;

        nativeBuildInputs = [ pkgs.sassc ];

        buildPhase = ''
          bash parse-sass.sh
        '';

        installPhase = ''
          mkdir -p $out/share/themes/${themeName}
          cp src/main/gtk-3.0/gtk-Dark.css $out/share/themes/${themeName}/gtk-3.0/gtk.css
          cp src/main/gtk-4.0/gtk-Dark.css $out/share/themes/${themeName}/gtk-4.0/gtk.css
          cp src/main/gnome-shell/gnome-shell-Dark.css $out/share/themes/${themeName}/gnome-shell/gnome-shell.css
          cp src/main/cinnamon/cinnamon-Dark.css $out/share/themes/${themeName}/cinnamon/cinnamon.css
          cp index.theme $out/share/themes/${themeName}/index.theme
        '';

        meta = with pkgs.lib; {
          description = "Sharabha GTK Theme — Skeuomorphic dark GTK theme";
          longDescription = ''
            A skeuomorphic GTK3/GTK4 theme based on the Sanatana Linux color palette
            by Thomas Leon Highbaugh. Features repeating linear gradient button
            backgrounds, 80% opacity window backgrounds, and a cohesive dark color
            scheme. Originally forked from Skeuos GTK by Daniel Ruiz de Alegría.
          '';
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.sassc ];
      };
    };
}
