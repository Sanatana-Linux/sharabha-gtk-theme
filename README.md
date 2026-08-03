# sharabha-gtk-theme

A skeuomorphic dark GTK2/GTK3/GTK4 theme featuring repeating linear gradient button backgrounds, 80% opacity window backgrounds, and a cohesive dark color scheme based on the **Sanatana Linux** color palette.

![sharabha-gtk-theme](https://raw.githubusercontent.com/thomasleonhighbaugh/sharabha-gtk/main/assets/preview.png)

## Color Palette

The theme uses the **Sanatana Linux** palette by Thomas Leon Highbaugh:

| Base    | Hex       | Role                        |
| ------- | --------- | --------------------------- |
| `base00`  | `#0c0c0c` | Default Background          |
| `base01`  | `#1c1c1c` | Lighter Background          |
| `base02`  | `#2c2c2c` | Selection Background        |
| `base03`  | `#59575f` | Comments, Invisible         |
| `base04`  | `#8b888f` | Light Foreground            |
| `base05`  | `#bab6c0` | Default Foreground          |
| `base06`  | `#d9d5df` | Light Accent Foreground     |
| `base07`  | `#f7f1ff` | Bright Accent Foreground    |
| `base08`  | `#fc618d` | Red                         |
| `base09`  | `#ff9e64` | Orange                      |
| `base0A`  | `#fce566` | Yellow                      |
| `base0B`  | `#7dca99` | Green                       |
| `base0C`  | `#59bbe5` | Cyan                        |
| `base0D`  | `#6b9ce8` | Blue                        |
| `base0E`  | `#948ae3` | Magenta                     |
| `base0F`  | `#555566` | Alt Grey Tone               |

## Features

- **Skeuomorphic buttons** — `repeating-linear-gradient(23deg, ...)` with state-specific color shifts
  - Normal: `#8b888f → #98959c → #555566` with `1px solid black` border
  - Hover: reversed gradient with `1px solid white` border
  - Active: 10% lighter gradient
  - Insensitive: solid `#555566`
  - Backdrop: 15% darker gradient
- **Accent color** — `#555566` (Sanatana `base0F`, alt grey tone) used for:
  - Selected text, list-rows, and infobars
  - Focus ring at 50% opacity with `lighten(#555566, 7.5%)` = `#66667b`
- **80% opacity** window backgrounds for a modern translucent look
- **Multi-desktop support** — see [Variants](#variants) below
- **Nix flake** for reproducible builds

## Variants

The theme ships as a single bundle in `share/themes/sharabha-gtk-theme/` with the following per-desktop subdirectories:

| Directory        | Format                            | Target                                                              |
| ---------------- | --------------------------------- | ------------------------------------------------------------------- |
| `gtk-2.0/`       | `gtkrc` (murrine engine)          | Legacy GTK2 apps on XFCE, MATE, Budgie, LibreOffice, etc.           |
| `gtk-3.0/`       | `gtk.css` (compiled from SCSS)    | GTK3 applications (Nautilus, gedit, GNOME Files settings, etc.)    |
| `gtk-4.0/`       | `gtk.css` (compiled from SCSS)    | GTK4 / libadwaita applications (gnome-text-editor, GNOME Builder)  |
| `gnome-shell/`   | `gnome-shell.css` (SCSS-compiled) | GNOME Shell (versions 3.28–48), including activities & top bar    |
| `cinnamon/`     | `cinnamon.css` (SCSS-compiled)   | Cinnamon desktop (Linux Mint)                                       |
| `xfwm4/`         | `themerc` + SVG assets           | XFCE window manager decorations (close/max/min/menu/shade/stick)   |
| `metacity-1/`    | `metacity-theme-3.xml` (Cairo)   | Metacity 3 / Marco / Mutter / GNOME-Flashback / UnityCompiz fallback |
| `unity/`         | symlink to `metacity-1/` + GTK CSS `UnityDecoration` styling already compiled into `gtk.css` | Unity 7 / Unity 8 (Compiz) |

> **Note on GTK2 / `murrine`** — The `gtk-2.0/gtkrc` file declares the `murrine` engine for gradient/relief styling on systems that have it. The `murrine` engine is deprecated on NixOS and not packaged as a runtime dependency of this flake; on NixOS (and other systems without `gtk-engine-murrine`), GTK2 will automatically fall back to the default engine. Colors from the `gtk_color_scheme` block still apply, only button gradients and reliefs render flat. No action needed — the fallback is silent.

## Building

### Using Nix (recommended)

```bash
nix build
```

Or to install directly:

```bash
nix run
```

### Using sassc directly

```bash
# Install sassc (if not using Nix)
# Debian/Ubuntu: sudo apt install sassc
# Fedora: sudo dnf install sassc
# Arch: sudo pacman -S sassc

# Build
bash parse-sass.sh
```

## Installation

### Local user install

```bash
mkdir -p ~/.themes/sharabha-gtk-theme/{gtk-3.0,gtk-4.0,gnome-shell,cinnamon,gtk-2.0,metacity-1,xfwm4,unity}
# SCSS-compiled CSS
cp src/main/gtk-3.0/gtk-Dark.css       ~/.themes/sharabha-gtk-theme/gtk-3.0/gtk.css
cp src/main/gtk-4.0/gtk-Dark.css       ~/.themes/sharabha-gtk-theme/gtk-4.0/gtk.css
cp src/main/gnome-shell/gnome-shell-Dark.css ~/.themes/sharabha-gtk-theme/gnome-shell/gnome-shell.css
cp src/main/cinnamon/cinnamon-Dark.css ~/.themes/sharabha-gtk-theme/cinnamon/cinnamon.css
# Static variants (no SCSS compilation)
cp src/main/gtk-2.0/gtkrc              ~/.themes/sharabha-gtk-theme/gtk-2.0/gtkrc
cp src/main/metacity-1/metacity-theme-3.xml ~/.themes/sharabha-gtk-theme/metacity-1/metacity-theme-3.xml
cp src/main/xfwm4/*                    ~/.themes/sharabha-gtk-theme/xfwm4/
ln -sf ../metacity-1/metacity-theme-3.xml ~/.themes/sharabha-gtk-theme/unity/metacity-theme-3.xml
# Theme metadata
cp index.theme                         ~/.themes/sharabha-gtk-theme/index.theme
```

### Activate

```bash
gsettings set org.gnome.desktop.interface gtk-theme "sharabha-gtk-theme"
gsettings set org.gnome.shell.extensions.user-theme name "sharabha-gtk-theme"
```

Or select **sharabha-gtk-theme** in GNOME Tweaks.

## Using with Stylix on NixOS

[Stylix](https://github.com/danth/stylix) is a NixOS module that applies a consistent color scheme across your system using base16 palettes. This guide shows two ways to combine sharabha-gtk-theme with Stylix on a NixOS flake-based setup.

### Option 1 — Theme package + Stylix color scheme

This approach uses sharabha-gtk-theme as the GTK theme while letting Stylix drive the rest of the system colors from the matching Sanatana base16 palette.

#### 1. Add the flake input

In your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    sharabha-gtk = {
      url = "github:thomasleonhighbaugh/sharabha-gtk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stylix, sharabha-gtk, ... }@inputs: {
    nixosConfigurations.yourhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        stylix.nixosModules.stylix
        ./configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
```

#### 2. Configure Stylix + GTK in `configuration.nix`

```nix
{ pkgs, inputs, ... }:

{
  # Font + color basics
  stylix = {
    enable = true;
    image = ./wallpapers/your-wallpaper.png;
    base16Scheme = {
      # Sanatana Linux palette (matches sharabha-gtk-theme)
      base00 = "0c0c0c";
      base01 = "1c1c1c";
      base02 = "2c2c2c";
      base03 = "59575f";
      base04 = "8b888f";
      base05 = "bab6c0";
      base06 = "d9d5df";
      base07 = "f7f1ff";
      base08 = "fc618d";
      base09 = "ff9e64";
      base0A = "fce566";
      base0B = "7dca99";
      base0C = "59bbe5";
      base0D = "6b9ce8";
      base0E = "948ae3";
      base0F = "555566";   # Sharabha accent
    };

    # Let sharabha-gtk-theme drive the GTK target
    targets.gtk.enable = true;
    targets.gtk.theme = {
      name = "sharabha-gtk-theme";
      package = inputs.sharabha-gtk.packages.${pkgs.system}.default;
    };
  };
}
```

#### What Stylix will override vs. what sharabha-gtk-theme keeps

Because sharabha-gtk-theme already implements the full Sanatana palette in its compiled CSS, you can let it own the GTK target while Stylix manages **everything else**:

- `stylix.targets.gtk.enable = true` + `theme.package` from this flake → sharabha-gtk-theme provides the CSS
- Stylix uses `base16Scheme` above to color other targets (foot, alacritty, bat, zsh-syntax-highlighting, fzf, rofi, etc.)
- Both draw from the same palette, so colors stay consistent across tools

> **Tip** — If you want Stylix to generate the GTK CSS from the palette instead of using the compiled sharabha-gtk-theme stylesheet, simply omit `stylix.targets.gtk.theme` and set `stylix.targets.gtk.enable = true`. You'll get Stylix's flat GTK output instead of sharabha-gtk-theme's skeuomorphic gradients. Use the approach above to keep the skeuomorphic look.

### Option 2 — Manual install (no Stylix, flake only)

If you don't use Stylix but still want sharabha-gtk-theme on NixOS from the flake:

```nix
{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.sharabha-gtk.packages.${pkgs.system}.default
  ];

  # Activate for the current user
  programs.dconf.enable = true;
}
```

Then enable in GNOME Tweaks or via gsettings:

```bash
gsettings set org.gnome.desktop.interface gtk-theme "sharabha-gtk-theme"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
```

The package installs to `/nix/store/<hash>-sharabha-gtk-theme-1.0.0/share/themes/sharabha-gtk-theme/`, which GNOME automatically discovers via the `XDG_DATA_DIRS` path.

### Option 3 — Home Manager + Stylix (per-user)

For a per-user setup with Home Manager and Stylix instead of system-wide NixOS modules:

```nix
# home.nix
{ pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = {
      base00 = "0c0c0c";
      base01 = "1c1c1c";
      base02 = "2c2c2c";
      base03 = "59575f";
      base04 = "8b888f";
      base05 = "bab6c0";
      base06 = "d9d5df";
      base07 = "f7f1ff";
      base08 = "fc618d";
      base09 = "ff9e64";
      base0A = "fce566";
      base0B = "7dca99";
      base0C = "59bbe5";
      base0D = "6b9ce8";
      base0E = "948ae3";
      base0F = "555566";
    };

    targets.gtk = {
      enable = true;
      theme = {
        name = "sharabha-gtk-theme";
        package = inputs.sharabha-gtk.packages.${pkgs.system}.default;
      };
    };
  };
}
```

### Sanity check

After activation, restart GNOME Shell (<kbd>Alt</kbd>+<kbd>F2</kbd> → `r` → <kbd>Enter</kbd>) or log out and back in. Verify:

- **GTK theme active:** `gsettings get org.gnome.desktop.interface gtk-theme` should return `'sharabha-gtk-theme'`
- **Accent color applied:** Select text in any text field — the highlight should appear as `#555566` (grey-blue) rather than the default blue
- **Skeuomorphic buttons:** Buttons in GTK3 apps (Nautilus, GNOME Files settings, etc.) should show a repeating gradient surface, not a flat fill
- **Focus ring:** Focused entry fields should display a translucent `#66667b` ring at 50% opacity around the input boundary

If sharabha-gtk-theme does not appear in GNOME Tweaks, run `nix-locate share/themes/sharabha-gtk-theme/index.theme` to confirm the path was added to `XDG_DATA_DIRS`.

## Credits

This theme is a fork of **[Skeuos GTK](https://github.com/daniruiz/skeuos-gtk)** by **Daniel Ruiz de Alegría** ([daniel@drasite.com](mailto:daniel@drasite.com)), originally licensed under GPLv3.

The structural layout and SCSS architecture are adapted from **[MacTahoe GTK Theme](https://github.com/...)**.

### Original Author

- **Daniel Ruiz de Alegría** — Original Skeuos GTK theme
- **Thomas Leon Highbaugh** — Sanatana Linux color palette, skeuomorphic styling, Nix flake

## License

GNU General Public License v3.0 — see [COPYING](./COPYING) for details.
