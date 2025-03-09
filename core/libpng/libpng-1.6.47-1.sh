# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="http://www.libpng.org/"
licenses=('libpng')
dependencies=('zlib/1.3.1-1')
build_dependencies=()
sources=("http://prdownloads.sourceforge.net/libpng/libpng-${package_version}.tar.xz")
sha256sums=('b213cb381fbb1175327bd708a77aab708a05adde7b471bc267bd15ac99893631')
package_options=()

handle_build() {
    export CFLAGS+=" ${c_flags}"

    cd $build_directory
    $source_directory/libpng-${package_version}/configure \
        --prefix=/usr

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
