# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo does

Automates full Linux workstation setup on **Fedora** or **Arch** using Ansible for system configuration and GNU Stow for dotfile management. Supports two window managers: **sway** (Wayland) or **i3** (X11), with optional Nvidia driver installation.

## Running the bootstrap

```bash
./bootstrap.sh <sway|i3> [nvidia]
```

This installs `ansible`, `stow`, and `git` via the distro package manager, then runs the Ansible playbook.

## Running Ansible directly (after deps are installed)

```bash
cd ansible
ansible-playbook site.yml -i inventory/localhost.yml -e "wm=sway" -e "nvidia=false" --ask-become-pass
```

Run a single role with `--tags` or limit to specific tasks using `--start-at-task`.

To check what would change without applying:
```bash
ansible-playbook site.yml -i inventory/localhost.yml -e "wm=sway" -e "nvidia=false" --ask-become-pass --check
```

## Architecture

### Ansible roles (run in order)

| Role | What it does |
|------|-------------|
| `repos` | Adds third-party repos (VS Code, Spotify via negativo17, RPM Fusion) — Fedora only |
| `packages` | Installs base packages, oh-my-zsh, Doom Emacs, rustup, npm prefix; runs `stow` for all common dotfiles |
| `services` | Enables system and user systemd services (vnstat, ollama, libvirtd, usbguard, emacs daemon) |
| `os-config` | Sets hostname (if `machine_hostname` var defined), generates usbguard policy, sets default shell to zsh |
| `sway` / `i3` | Installs WM-specific packages and stows the WM dotfiles |
| `nvidia` | Optional — installs Nvidia drivers |

### Distro differences

Per-distro vars live in `ansible/group_vars/fedora.yml` and `ansible/group_vars/arch.yml`. They set `pkg_manager` (`dnf` or `pacman`) and the package lists. All tasks branch on `pkg_manager`. Arch-only packages (VS Code, Spotify) must be installed from AUR manually.

### Dotfiles (stow)

Each subdirectory under `stow/` maps directly to `$HOME` via `stow -t ~`. The directory structure inside mirrors the target path (e.g. `stow/sway/.config/sway/config` → `~/.config/sway/config`).

Common stow targets: `zsh`, `doom-emacs`, `alacritty`, `git`, `tmux`, `gpg`, `scripts`, `sway` or `i3`.

To stow a single package manually:
```bash
stow -d stow -t ~ <package-name>
```
