# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="https://lz4.org/"
licenses=('BSD-2-Clause', 'GLPv2')
dependencies=()
build_dependencies=()
sources=("https://github.com/lz4/lz4/releases/download/v${package_version}/lz4-${package_version}.tar.gz")
sha256sums=('537512904744b35e232912055ccf8ec66d768639ff3abe5788d90d792ec5f48b')
package_options=()

handle_build() {
    export CFLAGS+=" ${c_flags}"

    cd $source_directory/lz4-${package_version}

    make \
        BUILD_STATIC=no \
        PREFIX=/usr \
        ${make_flags}
}

handle_check() {
    cd $source_directory/lz4-${package_version}
    make -j1 check
}

handle_package() {
    cd $source_directory/lz4-${package_version}

    make \
        BUILD_STATIC=no \
        PREFIX=$package_directory/usr \
        install
}
