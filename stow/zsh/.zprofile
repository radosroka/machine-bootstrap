if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec sway
elif [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi
