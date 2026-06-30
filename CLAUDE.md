# kiro-river — Claude project instructions

## Overview
Config package for the **Kiro river edition** — the classic dwm/xmonad-style dynamic tiler of the
KIROTUX Wayland line (sibling to [kiro-hyprland](../kiro-hyprland/CLAUDE.md)). Public, open-core,
shipped via `nemesis_repo`. Full research + decisions live in the internal
`Kiro-HQ/Kirotux/study-of-river.md`.

## Edition spec (the WM-variable matrix)
- **Compositor:** **river-classic** (the dynamic-tiling river — ships `river` + `riverctl` +
  `rivertile`). **NOT** the new compositor-only `river` 0.4+ — they file-conflict on
  `/usr/bin/river` (depending on the wrong one is a publish-blocker; study §6).
- **Config language:** an **executable `#!/bin/sh`** at `~/.config/river/init` — a script of
  `riverctl` calls. Config + autostart fused (dwm `run.sh` style). **Must stay `chmod +x`** or
  river silently falls back to defaults; `cp -a` in `package()` preserves the bit.
- **Desktop shell:** **waybar + mako + swaybg** — same stack as kiro-hyprland. waybar uses river's
  **native `river/tags`/`river/window` modules** (best bar integration in the line).
- **Autostart:** `scripts/autostart.sh` (`riverctl spawn …`), sourced from `init`.
- **Theming:** **pywal**. `set-theme.sh` regenerates `waybar/colors.css`, rewrites mako, and
  applies river border/background colours **live via `riverctl`** (0xRRGGBB — no reload needed).
- **Lock/idle:** hyprlock + hypridle, reusing kiro-hyprland's `hyprlock.conf` + betterlockscreen
  blur cache — matches kiro-wayfire/kiro-sway.
- **Layout generator:** built-in **rivertile** (zero build). `wideriver` (AUR, dwm/xmonad layouts)
  is the documented upgrade and would be the line's first `nemesis_repo` build.
- **Dependencies:** `river-classic` + the waybar stack, all from `extra` — **nothing into
  `nemesis_repo`**.

## Keybindings
- SUPER grammar ported from kiro-hyprland in river's **tag/dwm vocabulary**: CTRL+ALT launchers +
  SUPER+F1..F12 + `kiro-keybindings` on SUPER+CTRL+S. `focus-view next/previous`, `swap`, `zoom`,
  rivertile `main-ratio`/`main-count`, and **tags** (Super+1..9, a window can hold several at once
  — not numbered workspaces).
- `etc/skel/.config/river/keybindings.txt` mirrors `init` — keep in lockstep; a duplicate-chord
  scan must pass. (`kiro-keybindings` / `/kiro-create-keybindings` still need **river** in their
  WM-detection table — known gap, same one Hyprland/niri/wayfire/sway hit.)

## Patterns / gotchas
- **`init` must be executable** — the single biggest river trap. Verify the +x bit survives the
  package build.
- **river-classic, never `river`** — they conflict on `/usr/bin/river`.
- **Tags ≠ workspaces** — keybindings.txt and any borrowed config speak river's bitmask tags.
- **river has no per-window opacity** — so no transparent terminal (unlike hyprland/wayfire/sway).
- Config **not yet validated on a real river boot** — confirm `rule-add`, `keyboard-layout`,
  `input "*touchpad*"` syntax against the installed river-classic before the first ISO test
  (same caveat niri/wayfire/sway carried).

## Build / delivery
- Source-of-truth for the config; delivered as the `kiro-river` package via
  `../KIROTUX-PKG-BUILD/kiro-river/build.sh` (public recipe → `~/EDU/nemesis_repo/`). After editing
  here: rebuild the package (recipe `build.sh`), then the ISO to test a fresh install.
- See [../CLAUDE.md](../CLAUDE.md) for the full KIROTUX delivery architecture.
