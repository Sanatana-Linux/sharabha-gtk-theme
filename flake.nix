{
  description = "sharabha-gtk-theme — A skeuomorphic GTK theme based on the Sanatana Linux color palette";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      themeName = "sharabha-gtk-theme";
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "sharabha-gtk-theme";
        version = "1.0.0";

        src = ./.;

        nativeBuildInputs = [ pkgs.sassc pkgs.imagemagick ];

        buildPhase = ''
          bash parse-sass.sh

          # Convert xfwm4 SVG assets to PNG for older xfwm4 builds that lack rsvg support.
          # xfwm4 4.12+ supports SVG directly via librsvg; earlier versions (and some
          # distro builds compiled without rsvg) only consume PNG. ImageMagick handles
          # the conversion at build time so the installed theme works everywhere.
          echo "==> Converting xfwm4 SVG assets to PNG fallbacks..."
          for svg in src/main/xfwm4/*.svg; do
            png="''${svg%.svg}.png"
            ${pkgs.imagemagick}/bin/convert "$svg" -density 96 "$png" 2>/dev/null || true
          done
          # Move PNGs next to their SVG siblings in the same directory (conversion writes
          # to the same dir, so nothing to move — the loop already placed them there).
        '';

        installPhase = ''
          mkdir -p $out/share/themes/${themeName}/{gtk-3.0,gtk-4.0,gnome-shell,cinnamon,gtk-2.0,metacity-1,xfwm4,unity}

          # GTK3 / GTK4 (SCSS-compiled)
          cp src/main/gtk-3.0/gtk-Dark.css $out/share/themes/${themeName}/gtk-3.0/gtk.css
          cp src/main/gtk-4.0/gtk-Dark.css $out/share/themes/${themeName}/gtk-4.0/gtk.css

          # GNOME Shell + Cinnamon (SCSS-compiled)
          cp src/main/gnome-shell/gnome-shell-Dark.css $out/share/themes/${themeName}/gnome-shell/gnome-shell.css
          cp src/main/cinnamon/cinnamon-Dark.css $out/share/themes/${themeName}/cinnamon/cinnamon.css

          # GTK2 (static gtkrc — no compilation)
          cp src/main/gtk-2.0/gtkrc $out/share/themes/${themeName}/gtk-2.0/gtkrc

          # Metacity 3 window decorations (static XML)
          cp src/main/metacity-1/metacity-theme-3.xml $out/share/themes/${themeName}/metacity-1/metacity-theme-3.xml

          # XFWM4 window decorations — ship BOTH SVG (modern xfwm4) and PNG (older builds)
          cp src/main/xfwm4/themerc $out/share/themes/${themeName}/xfwm4/themerc
          cp src/main/xfwm4/*.svg   $out/share/themes/${themeName}/xfwm4/
          cp src/main/xfwm4/*.png   $out/share/themes/${themeName}/xfwm4/

          # Unity (uses metacity-1 +GtkApplicationUSD styling already in gtk-Dark.css;
          # provide a symlinked unity/ directory pointing to metacity-1 for window fallbacks)
          ln -sf ../metacity-1/metacity-theme-3.xml $out/share/themes/${themeName}/unity/metacity-theme-3.xml

          # Theme metadata
          cp index.theme $out/share/themes/${themeName}/index.theme
        '';

        meta = with pkgs.lib; {
          description = "sharabha-gtk-theme — Skeuomorphic dark GTK theme";
          longDescription = ''
            A skeuomorphic GTK2/GTK3/GTK4 theme based on the Sanatana Linux color palette
            by Thomas Leon Highbaugh. Features repeating linear gradient button
            backgrounds, 80% opacity window backgrounds, and a cohesive dark color
            scheme. Includes variants for GNOME Shell, Cinnamon, XFWM4 (with PNG
            fallbacks for older builds), Metacity 3, Unity, and legacy GTK2.
            Originally forked from Skeuos GTK by Daniel Ruiz de Alegría.
          '';
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.sassc pkgs.imagemagick ];
      };
    };
}