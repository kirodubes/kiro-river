# Changelog

All notable changes to **kiro-river** are documented here.
Format: one dated entry per day (`YYYY.MM.DD`), newest first.

## 2026.07.01

### What Changed
- **Added Variety wallpaper-rotator autostart + keybinds.** `variety` (configured by
  `kiro-variety-config`) now autostarts alongside the existing static `swaybg` wallpaper. Ported
  the ohmychadwm `keybindings.txt` scheme (alt+N/P/T/F/arrows/Up/Down/W): next/previous/trash/
  favorite/pause/resume/selector, plus alt+shift+N/P/T/F/U combos that also trigger this edition's
  `set-theme.sh` pywal recolor (waybar + live `riverctl` border colours). `variety` +
  `kiro-variety-config` added to `depends=()`.

### Technical Details
- riverctl's `spawn` already runs its argument through the user's shell, so the recolor combos are
  single-quoted directly (matching the existing screenshot binds) rather than manually wrapped in
  an extra `sh -c` — an earlier draft over-wrapped this and was corrected.
- Verified no existing bare-Alt binds collided with alt+n/p/t/f/w/arrows before adding (only
  `Control+Alt` combos existed on those keys).

### Files Modified
- [etc/skel/.config/river/init](etc/skel/.config/river/init)
- [etc/skel/.config/river/scripts/autostart.sh](etc/skel/.config/river/scripts/autostart.sh)
- [etc/skel/.config/river/keybindings.txt](etc/skel/.config/river/keybindings.txt)
- [../KIROTUX-PKG-BUILD/kiro-river/PKGBUILD](../KIROTUX-PKG-BUILD/kiro-river/PKGBUILD)

## 2026.06.30

### What Changed
- **Moved shared dotfiles into the new `kiro-wayland-dotfiles` base** — mako, hyprlock/hypridle,
  and the waybar `colors.css`/`style.css` now come from that package (resolves the cross-edition
  file conflict, e.g. kiro-hyprland ↔ kiro-river both owning `~/.config/mako/config`). This edition
  now ships only its `waybar/config-<wm>.jsonc` and launches `waybar -c` against it.
- **Initial config package** for the Kiro river edition — the classic dwm/xmonad-style dynamic
  tiler of the KIROTUX Wayland line. Ships the same waybar + mako + swaybg shell as kiro-hyprland,
  so the look and feel match; the SUPER keybind grammar is ported onto river's tag-based vocabulary.
- **Ships river-classic** (the dynamic-tiling river with `riverctl`/`rivertile`), explicitly NOT
  the new compositor-only `river` 0.4+ (they file-conflict on `/usr/bin/river`).
- **Native waybar tags** — river's `river/tags`/`river/window` modules give real tag pills (the
  best native waybar integration in the line; wayfire had to fall back to `wlr/taskbar`).
- **pywal theming** — one wallpaper drives every colour: `set-theme.sh` runs pywal at login and
  fans the palette out to waybar, mako, and river's borders (applied live via `riverctl`).
- **Fixed waybar appearing ~25s late at login** — the bar process started on time but its window
  only painted after a long stall. Cause: waybar (GTK) was spawned concurrently with the dbus
  environment setup and blocked on the at-spi accessibility bus before drawing. Now spawned as
  `GTK_A11Y=none waybar`, which skips the a11y bus it never uses, so the bar paints immediately.

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
