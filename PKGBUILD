# Maintainer: Bruno Gonçalves <bigbruno@gmail.com>
# Maintainer: Tales A. Mendonça <talesam@gmail.com>

pkgname=biglinux-keyring
pkgdesc="BigLinux PGP keyring"
depends=('pacman')
pkgver=$(date +%y.%m.%d)
pkgrel=$(date +%H%M)
epoch=1
arch=('any')
license=('MIT')
url="https://github.com/biglinux/${pkgname}"
source=("git+${url}.git")
sha256sums=('SKIP')
install="${pkgname}.install"

prepare() {
  cd "${srcdir}/${pkgname}"

  echo "d076880d07717653262a4ddbf13bfdd78008e673ab6b8fdcf9724eea9aebe185 Makefile" | sha256sum -c || exit 1
  echo "170070706da7bc7d0d3eeb896002611c4db4fa3aca08ca26347ca3c77cc2c635 biglinux.gpg" | sha256sum -c || exit 1
  echo "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 biglinux-revoked" | sha256sum -c || exit 1
  echo "4f7856e01f3fb2bf287cb6e0dfb854203c9efb41aba6a27cb34f3912c12885a0 biglinux-trusted" | sha256sum -c || exit 1
}

package() {
  cd "${srcdir}/${pkgname}"
  make DESTDIR="${pkgdir}" install
}
