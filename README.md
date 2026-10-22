# biglinux-keyring

PGP keyring used by pacman to verify the packages published in the BigLinux
repositories (`packages.biglinux.com.br`).

The package installs the keys to `/usr/share/pacman/keyrings/` and runs
`pacman-key --populate biglinux`, so pacman trusts the BigLinux signing keys
right after installation or upgrade.

## Trusted keys

| Fingerprint | Owner |
|---|---|
| `F7EB9C2849EFFEFF05789738047C6A782618D2CA` | BigLinux Package Signing (current) |
| `0AA022108998AA79A5C4997C45EC44879815E2A6` | BigLinux_2021 |
| `099D22B956B9ED89263112F700859BF076EAE71F` | Rafael Augusto Ruscher (BigLinux Packager) |

## Using the repository on a new system

The keyring package is itself signed with the BigLinux key, so trust the
current key once before installing it. The key is published on
`keyserver.ubuntu.com`, the default keyserver of GnuPG and pacman-key:

```bash
sudo pacman-key --recv-keys 047C6A782618D2CA && sudo pacman-key --lsign-key 047C6A782618D2CA
```

`047C6A782618D2CA` is the long ID of the key (the last 16 characters of the
fingerprint). The full fingerprint works too:
`F7EB9C2849EFFEFF05789738047C6A782618D2CA`.

Then add the repositories to `/etc/pacman.conf`. Every section uses the same
line, as Arch and Manjaro do: pacman replaces `$repo` with the section name.
`[biglinux-priority]` goes above Manjaro's `[core]`, the others after
Manjaro's sections:

```ini
[biglinux-priority]
SigLevel = PackageRequired
Server = https://packages.biglinux.com.br/$repo/$arch

[core]
...

[biglinux-testing]
SigLevel = PackageRequired
Server = https://packages.biglinux.com.br/$repo/$arch

[biglinux-stable]
SigLevel = PackageRequired
Server = https://packages.biglinux.com.br/$repo/$arch

[biglinux-extra]
SigLevel = PackageRequired
Server = https://packages.biglinux.com.br/$repo/$arch
```

`biglinux-priority` holds BigLinux builds of packages Manjaro also has.
`biglinux-testing` is optional: it receives packages before `biglinux-stable`.
`biglinux-extra` holds AUR and third-party packages. Then install the keyring,
which keeps the keys up to date from now on:

```bash
sudo pacman -Syu biglinux-keyring
```

If the keyserver answers `No data` right after a key update, restart pacman's
dirmngr and try again:

```bash
sudo gpgconf --homedir /etc/pacman.d/gnupg --kill dirmngr
```

## Updating the keys

1. Add or remove fingerprints in `biglinux-trusted` (format `FINGERPRINT:4:`)
   and `biglinux-revoked` (one fingerprint per line).
2. Regenerate `biglinux.gpg` from the keyservers:

   ```bash
   make update
   ```

3. Update the sha256 checks in the `prepare()` function of the `PKGBUILD`:

   ```bash
   sha256sum Makefile biglinux.gpg biglinux-revoked biglinux-trusted
   ```

4. Commit and build the package. The version comes from the build date.

## License

MIT
