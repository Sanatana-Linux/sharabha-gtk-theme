#!/usr/bin/env bash
# lib-install.sh — Theme installation functions

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)"

function install_theme() {
	local theme_name="Sharabha-GTK"
	local install_dir="${1:-$HOME/.themes}"

	echo "Installing ${theme_name} to ${install_dir}..."

	mkdir -p "$install_dir"
	cp -r "${REPO_DIR}/release/${theme_name}" "${install_dir}/"

	echo "Theme installed to ${install_dir}/${theme_name}"
	echo "You can now select it using GNOME Tweaks or your system settings."
}

function install_theme_system() {
	if [ "$EUID" -ne 0 ]; then
		echo "Please run with sudo to install system-wide."
		return 1
	fi
	install_theme "/usr/share/themes"
}
