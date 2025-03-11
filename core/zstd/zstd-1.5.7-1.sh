# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="https://facebook.github.io/zstd/"
licenses=('BSD-3-Clause')
dependencies=()
build_dependencies=()
sources=("https://github.com/facebook/zstd/releases/download/v${package_version}/zstd-${package_version}.tar.gz")
sha256sums=('eb33e51f49a15e023950cd7825ca74a4a2b43db8354825ac24fc1b7ee09e6fa3')
package_options=()

handle_build() {
    export CFLAGS+=" ${c_flags}"

    cd $source_directory/zstd-${package_version}

    make \
        PREFIX=/usr \
        ${make_flags}
}

handle_check() {
    cd $source_directory/zstd-${package_version}
    make ${make_flags} check
}

handle_package() {
    cd $source_directory/zstd-${package_version}
    
    make \
        PREFIX=$package_directory/usr \
        install

    rm -f $package_directory/usr/lib/libzstd.a
}
