# Obsidian Sync

Puts your Ambxst theme in Obsidian. On every theme change, the mod writes a CSS snippet, `.obsidian/snippets/ambxst.css`, in each vault, built from `~/.cache/ambxst/colors.json`. Obsidian reloads enabled snippets when their file changes, so open windows follow the theme at once. Nothing to install in Obsidian.

## Install

In **Settings > Mods**, install from `https://github.com/Ecta250/ambxst-obsidian-sync.git`, enable the mod, then restart Ambxst. Or:

```sh
ambxst mods install https://github.com/Ecta250/ambxst-obsidian-sync.git
ambxst mods enable ecta250.obsidian-sync
ambxst reload
```

Requires Obsidian, `python3`, and Ambxst 1.3.14 or newer.

## Vaults

By default the mod uses every vault listed in Obsidian's `obsidian.json` (`~/.config/obsidian` or the Flatpak folder). To choose others, list their folders in **Settings > Mods > Obsidian Sync > Obsidian vaults**, separated by commas.

The snippet is turned on in each vault the first time. To stop the colours in a vault, turn **ambxst** off in Obsidian's **Settings > Appearance > CSS snippets**; it stays off. If a vault was open while the mod turned the snippet on and the colours do not show, turn it on there by hand once.

The snippet sets Obsidian's colour variables, so it works over the default theme. Community themes that set their own colours with higher specificity may win over some of them.

## Dark and light

With **Match dark/light** on, Obsidian's base theme follows the Ambxst palette: dark with a dark background, light otherwise.

Manual run: `python3 scripts/obsidian_sync.py [--enable] [--match-mode] [--vault DIR]`
