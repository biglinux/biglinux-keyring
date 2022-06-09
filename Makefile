V=20220514

PREFIX = /usr/local

update:
	gpg --recv-keys $(cat biglinux-trusted | cut -d: -f1) $(cat biglinux-revoked)
	gpg --export --armor $(cat biglinux-trusted | cut -d: -f1) $(cat biglinux-revoked) > biglinux.gpg

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 biglinux{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/biglinux{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
