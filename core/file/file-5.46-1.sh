# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="https://www.darwinsys.com/file/"
licenses=('Custom')
dependencies=()
build_dependencies=()
sources=("https://astron.com/pub/file/file-${package_version}.tar.gz")
sha256sums=('c9cc77c7c560c543135edc555af609d5619dbef011997e988ce40a3d75d86088')
package_options=()

handle_build() {
    export CFLAGS+=" ${c_flags}"

    cd $build_directory

    $source_directory/file-${package_version}/configure \
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
