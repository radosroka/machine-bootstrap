#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

install_deps_fedora() {
    sudo dnf install -y ansible stow git
}

install_deps_arch() {
    sudo pacman -Sy --noconfirm ansible stow git
}

DISTRO=$(detect_distro)

case "$DISTRO" in
    fedora)  install_deps_fedora ;;
    arch)    install_deps_arch ;;
    *)       echo "Unsupported distro: $DISTRO"; exit 1 ;;
esac

cd "$REPO_DIR/ansible"
ansible-playbook site.yml -i inventory/localhost.yml --ask-become-pass "$@"
