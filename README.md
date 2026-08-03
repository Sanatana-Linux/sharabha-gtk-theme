# Sharabha GTK Theme

A skeuomorphic dark GTK3/GTK4 theme featuring repeating linear gradient button backgrounds, 80% opacity window backgrounds, and a cohesive dark color scheme based on the **Sanatana Linux** color palette.

![Sharabha GTK Theme](https://raw.githubusercontent.com/thomasleonhighbaugh/sharabha-gtk/main/assets/preview.png)

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
  - Active: 15% lighter gradient
  - Insensitive: solid `#555566`
  - Backdrop: 15% darker gradient
- **80% opacity** window backgrounds for a modern translucent look
- **GTK3** and **GTK4** support
- **GNOME Shell** support (multiple versions: 3.28–48)
- **Cinnamon** support
- **Nix flake** for reproducible builds

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
mkdir -p ~/.themes/Sharabha-GTK
cp src/main/gtk-3.0/gtk-Dark.css ~/.themes/Sharabha-GTK/gtk-3.0/gtk.css
cp src/main/gtk-4.0/gtk-Dark.css ~/.themes/Sharabha-GTK/gtk-4.0/gtk.css
cp src/main/gnome-shell/gnome-shell-Dark.css ~/.themes/Sharabha-GTK/gnome-shell/gnome-shell.css
cp src/main/cinnamon/cinnamon-Dark.css ~/.themes/Sharabha-GTK/cinnamon/cinnamon.css
cp index.theme ~/.themes/Sharabha-GTK/index.theme
```

### Activate

```bash
gsettings set org.gnome.desktop.interface gtk-theme "Sharabha-GTK"
gsettings set org.gnome.shell.extensions.user-theme name "Sharabha-GTK"
```

Or select **Sharabha-GTK** in GNOME Tweaks.

## Credits

This theme is a fork of **[Skeuos GTK](https://github.com/daniruiz/skeuos-gtk)** by **Daniel Ruiz de Alegría** ([daniel@drasite.com](mailto:daniel@drasite.com)), originally licensed under GPLv3.

The structural layout and SCSS architecture are adapted from **[MacTahoe GTK Theme](https://github.com/...)**.

### Original Author

- **Daniel Ruiz de Alegría** — Original Skeuos GTK theme
- **Thomas Leon Highbaugh** — Sanatana Linux color palette, skeuomorphic styling, Nix flake

## License

GNU General Public License v3.0 — see [COPYING](./COPYING) for details.
