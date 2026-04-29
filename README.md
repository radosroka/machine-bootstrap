# machine-bootstrap

Automated Linux workstation setup for **Fedora** and **Arch Linux** using Ansible + GNU Stow.

## Features

- Package installation and third-party repo setup (VS Code, Spotify, RPM Fusion)
- Dotfile management via `stow` (zsh, alacritty, tmux, git, gpg, doom-emacs, sway/i3)
- Systemd service enablement (ollama, libvirtd, usbguard, emacs daemon)
- Choice of window manager: **sway** (Wayland) or **i3** (X11)
- Optional Nvidia driver installation
- Shell set to zsh + oh-my-zsh, Doom Emacs, rustup installed automatically

## Usage

```bash
./bootstrap.sh <sway|i3> [nvidia]
```

Examples:

```bash
./bootstrap.sh sway          # Sway WM, no Nvidia
./bootstrap.sh i3 nvidia     # i3 WM with Nvidia drivers
```

The script auto-detects Fedora or Arch, installs `ansible`, `stow`, and `git`, then runs the playbook. It will prompt for your sudo password.

## Supported distros

| Distro | Package manager | Notes |
|--------|----------------|-------|
| Fedora | dnf | VS Code and Spotify repos added automatically |
| Arch   | pacman | VS Code and Spotify require AUR (`yay`) |

## Manual stow

To symlink a single dotfile package into `$HOME`:

```bash
stow -d stow -t ~ <package>
# e.g. stow -d stow -t ~ tmux
```

## Optional: set hostname

Pass `machine_hostname` as an extra var:

```bash
cd ansible
ansible-playbook site.yml -i inventory/localhost.yml \
  -e "wm=sway" -e "nvidia=false" -e "machine_hostname=mybox" \
  --ask-become-pass
```
