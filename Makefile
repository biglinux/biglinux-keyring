PREFIX = /usr
TRUSTED= $(shell cat biglinux-trusted | cut -d: -f1)
REVOKED= $(shell cat biglinux-revoked)

update:
	gpg --recv-keys $(TRUSTED) $(REVOKED)
	gpg --export --armor $(TRUSTED) $(REVOKED) > biglinux.gpg

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 biglinux{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/biglinux{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
