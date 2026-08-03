#!/usr/bin/env bash
# lib-core.sh — Core theme functions

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)"
SRC_DIR="${REPO_DIR}/src"

function has_command() {
	command -v $1 >/dev/null
}

function build_theme() {
	echo "Building Sharabha GTK Theme..."
	cd "$REPO_DIR"
	bash parse-sass.sh
	echo "Build complete."
}
