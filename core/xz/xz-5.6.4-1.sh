# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="https://tukaani.org/xz"
licenses=('BSD-0-Clause', 'GPLv2', 'GPLv3', 'LGPLv2.1')
dependencies=()
build_dependencies=()
sources=("https://github.com/tukaani-project/xz/releases/download/v${package_version}/xz-${package_version}.tar.xz")
sha256sums=('829ccfe79d769748f7557e7a4429a64d06858e27e1e362e25d01ab7b931d9c95')
package_options=()

handle_build() {
    export CFLAGS+=" ${c_flags}"

    cd $build_directory
    $source_directory/xz-${package_version}/configure \
        --prefix=/usr \
        --disable-static \
        --docdir=/usr/share/doc/xz-${package_version}

    make ${make_flags}
}

handle_check() {
    cd $build_directory
    make ${make_flags} check
}

handle_package() {
    cd $build_directory
    make DESTDIR=$package_directory install
}
