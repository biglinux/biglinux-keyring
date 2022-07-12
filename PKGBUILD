# BigLinux <bigbruno[at]gmail.com>

# Manjaro credits
# Maintainer: Philip Müller <philm[at]manjaro[dot]org>
# Maintainer: Bernhard Landauer <bernhard[at]manjaro[dot]org>

# Arch credits:
# Pierre Schmitz <pierre@archlinux.de>

pkgname=biglinux-keyring
pkgver=20220712
pkgrel=3
pkgdesc='BigLinux PGP keyring'
arch=('any')
url='http://biglinux.com.br'
license=('GPL')
install="${pkgname}.install"
source=('Makefile'
        'biglinux.gpg'
        'biglinux-revoked'
        'biglinux-trusted')
sha256sums=('fc040780e49d3ae9179435d4d2aef98270135f98eb0188c93e50f5ce987f1e00'
            '219ee16e9f94bdda9ed39a157704d67fb67d8dcfc3a201ef294f24c1bb07c5fb'
            'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
            '3669cb47860084f3466398c83ef1f125763b957b928acdb27c72f24d38521564')

package() {
  cd "${srcdir}"
  make PREFIX=/usr DESTDIR=${pkgdir} install
}
