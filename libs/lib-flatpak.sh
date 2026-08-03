#!/usr/bin/env bash
# lib-flatpak.sh — Flatpak theme override functions

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)"

function install_flatpak_theme() {
	local theme_dir="${REPO_DIR}/release"
	local flatpak_dirs=(
		"/var/lib/flatpak/app"
		"$HOME/.local/share/flatpak/app"
	)

	echo "Installing theme for Flatpak applications..."

	for flatpak_dir in "${flatpak_dirs[@]}"; do
		if [ -d "$flatpak_dir" ]; then
			find "$flatpak_dir" -maxdepth 3 -type d -name "active" | while read -r active_dir; do
				local target_dir="${active_dir}/files/share/themes/Sharabha-GTK"
				mkdir -p "$(dirname "$target_dir")"
				ln -sf "$theme_dir/Sharabha-GTK" "$target_dir" 2>/dev/null
			done
		fi
	done

	echo "Flatpak theme installation complete."
}
