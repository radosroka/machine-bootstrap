#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    echo "Usage: $0 <wm> [nvidia]"
    echo "  wm:    sway or i3"
    echo "  nvidia: pass 'nvidia' to install nvidia drivers"
    exit 1
}

[ "${1:-}" = "" ] && usage
WM="$1"
shift

if [[ "$WM" != "sway" && "$WM" != "i3" ]]; then
    echo "Error: wm must be 'sway' or 'i3'"
    usage
fi

NVIDIA=false
if [[ "${1:-}" == "nvidia" ]]; then
    NVIDIA=true
    shift
fi

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
ansible-playbook site.yml -i inventory/localhost.yml \
    -e "wm=$WM" \
    -e "nvidia=$NVIDIA" \
    --ask-become-pass "$@"
