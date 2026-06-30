# Changelog

All notable changes to **kiro-river** are documented here.
Format: one dated entry per day (`YYYY.MM.DD`), newest first.

## 2026.06.30

### What Changed
- **Initial config package** for the Kiro river edition — the classic dwm/xmonad-style dynamic
  tiler of the KIROTUX Wayland line. Ships the same waybar + mako + swaybg shell as kiro-hyprland,
  so the look and feel match; the SUPER keybind grammar is ported onto river's tag-based vocabulary.
- **Ships river-classic** (the dynamic-tiling river with `riverctl`/`rivertile`), explicitly NOT
  the new compositor-only `river` 0.4+ (they file-conflict on `/usr/bin/river`).
- **Native waybar tags** — river's `river/tags`/`river/window` modules give real tag pills (the
  best native waybar integration in the line; wayfire had to fall back to `wlr/taskbar`).
- **pywal theming** — one wallpaper drives every colour: `set-theme.sh` runs pywal at login and
  fans the palette out to waybar, mako, and river's borders (applied live via `riverctl`).

### Technical Details
- `etc/skel/.config/river/init` is the executable config (`chmod +x`, preserved by `cp -a` in
  `package()`) — river's config + autostart fused in one `riverctl` shell script (the Wayland
  line's closest fit to ohmychadwm's `run.sh`). Holds keybinds, the tags loop, appearance, window
  rules, and starts `rivertile`. Session autostart is split into `scripts/autostart.sh`
  (`riverctl spawn …`).
- Keybinds in river vocabulary: app launchers (CTRL+ALT + SUPER+F1..F12), `focus-view next/previous`,
  `swap`, `zoom`, `send-layout-cmd rivertile main-ratio/main-count`, and the dwm-style **tags**
  (Super+1..9 = `set-focused-tags`, a window can hold several tags). `kiro-keybindings` on SUPER+CTRL+S.
- **Layout = rivertile** (built into river-classic) — zero build. `wideriver` (dwm/xmonad layouts)
  is the documented upgrade and would be the line's first `nemesis_repo` build.
- **Shell ported from kiro-hyprland** — waybar with native river modules; `mako/config` + `style.css`
  carry Tokyo Night defaults, overwritten at login by pywal.
- **Lock pipeline** = hyprlock + hypridle, reusing kiro-hyprland's `hyprlock.conf` + the
  betterlockscreen blur cache (matches kiro-wayfire/kiro-sway for cross-edition consistency).
- Everything from `extra` — **nothing built into `nemesis_repo`** (with rivertile).

### Files
- `etc/skel/.config/river/init` (+x) + `scripts/{autostart.sh,set-theme.sh,import-gsettings.sh}` (+x)
- `etc/skel/.config/river/{keybindings.txt,bg/kiro.jpg}`
- `etc/skel/.config/waybar/{config.jsonc,style.css,colors.css}`
- `etc/skel/.config/mako/config`
- `etc/skel/.config/hypr/{hyprlock.conf,hypridle.conf}`
- `README.md`, `CLAUDE.md`, `up.sh`, `setup.sh`, `.gitignore`, `kiro.jpg`

### Not yet verified
- The `init` is **not validated on a real river-classic boot** (not installed on the build box) —
  run it on a real river session before/at first ISO test, same caveat niri/wayfire/sway carried.
  Confirm the `riverctl rule-add`, `keyboard-layout`, and `input "*touchpad*"` syntax against the
  installed river-classic version.
- `kiro-keybindings` / `/kiro-create-keybindings` still need **river** added to their WM-detection
  table (known gap, same one Hyprland/niri/wayfire/sway hit).
