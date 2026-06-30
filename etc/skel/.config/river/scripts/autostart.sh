#!/bin/sh
#####################################################################
# Author    : Erik Dubois
# Website   : https://kiroproject.be
#####################################################################
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
# Purpose:
#   Session autostart for the Kiro river edition, called from ~/.config/river/init.
#   Each service is launched with `riverctl spawn` so river owns the process.
# Why:
#   river's init IS config + autostart fused (dwm run.sh style); keeping the
#   spawns in their own file mirrors Kiro's autostart-script culture.
#####################################################################

# Authentication agent + environment for portals/screensharing.
riverctl spawn "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
riverctl spawn "dbus-update-activation-environment --systemd --all"
riverctl spawn "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

# Create the XDG user dirs on first login (river doesn't run /etc/xdg/autostart).
riverctl spawn "xdg-user-dirs-update"

# Mirror GTK theme/icons/cursor/font into gsettings for GTK4/libadwaita apps.
riverctl spawn "$HOME/.config/river/scripts/import-gsettings.sh"

# Wallpaper + pywal theming (palette → waybar/mako/river borders).
riverctl spawn "swaybg -m fill -i $HOME/.config/river/bg/kiro.jpg"
riverctl spawn "$HOME/.config/river/scripts/set-theme.sh"

# Bar, notifications, idle-lock daemon, network applet.
# GTK_A11Y=none: skip the at-spi accessibility bus so waybar paints immediately
# at login instead of stalling ~25s waiting for a bus it never uses.
riverctl spawn "GTK_A11Y=none waybar -c $HOME/.config/waybar/config-river.jsonc"
riverctl spawn "mako"
riverctl spawn "hypridle"
riverctl spawn "nm-applet --indicator"

# Live ISO only: auto-launch the installer. kiro_final strips this line on install.
riverctl spawn "sh -c '[ -d /run/archiso/bootmnt ] && calamares_polkit -d -style kvantum'"
