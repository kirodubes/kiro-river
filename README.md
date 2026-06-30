# kiro-river

The **river desktop edition** of Kiro — the classic dwm/xmonad-style dynamic tiler of the Kiro Wayland line (sibling to [kiro-hyprland](https://github.com/kirodubes/kiro-hyprland)).

## What it is

A configuration package: the source-of-truth config tree for Kiro's river edition. river is a
dynamic-tiling, **tag-based** wlroots compositor inspired by dwm and xmonad. Its config *is* an
executable shell script (`~/.config/river/init`) of `riverctl` calls — config and autostart fused,
the closest the Kiro Wayland line gets to ohmychadwm's `run.sh` culture. It ships the same
**waybar + mako + swaybg** shell as kiro-hyprland, and waybar uses river's **native `river/tags`
module** — the best bar integration in the line.

Ships **river-classic** (the dynamic-tiling river with `riverctl`/`rivertile`), not the new
compositor-only `river`. Layout is the built-in **rivertile**; `wideriver` is an optional upgrade.

## What it ships

- `etc/skel/.config/river/init` — the executable config: keybinds (SUPER grammar + CTRL+ALT +
  SUPER+F1..F12), tags, appearance, window rules, rivertile.
- `etc/skel/.config/river/scripts/` — `autostart.sh` (session services), `set-theme.sh` (pywal),
  `import-gsettings.sh`.
- `etc/skel/.config/waybar/` — the bar (`config.jsonc` with native river modules, `style.css`,
  pywal-driven `colors.css`).
- `etc/skel/.config/mako/config` — notifications.
- `etc/skel/.config/hypr/{hyprlock.conf,hypridle.conf}` — the Wayland lock pipeline.

## Theming — pywal

One wallpaper drives every colour. At login `set-theme.sh` runs pywal on the wallpaper and fans
the palette out to waybar, mako, and river's window borders (applied live via `riverctl`).
Re-theme any time with `~/.config/river/scripts/set-theme.sh /path/to/wallpaper.jpg`.

## How to install

```sh
sudo pacman -S kiro-river
```

`kiro-river` depends on `river-classic` + the waybar stack + `python-pywal` (all from `extra`).
On a fresh login river runs its `init`, starts the bar and wallpaper. Press **Super + Ctrl + S**
for the searchable keybindings cheat sheet. Workspaces are **tags** (Super+1..9), dwm-style.

A pristine copy of the config is kept at `/usr/share/kiro/kiro-river/` so it can be restored.
