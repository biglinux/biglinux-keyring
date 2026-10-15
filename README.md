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
current key once before installing it:

```bash
sudo pacman-key --recv-keys F7EB9C2849EFFEFF05789738047C6A782618D2CA --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F7EB9C2849EFFEFF05789738047C6A782618D2CA
sudo pacman -Sy biglinux-keyring
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
