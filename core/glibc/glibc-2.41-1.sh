# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="https://www.gnu.org/software/libc/"
licenses=('GPLv2')
dependencies=()
build_dependencies=()
sources=(
    "https://ftp.gnu.org/gnu/glibc/glibc-${package_version}.tar.xz"
    "ld.so.conf"
    "nsswitch.conf"
)
sha256sums=(
    "a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901"
    "64f705c0635d7c419f9703e878115d9c58c0af396a33cb67e38685b5c47222c8"
    "23479afd5155e1220866a8ae79bd408739642559c8fd463694dffea1cfa7ad68"
)
package_options=()

handle_build() {
    export CFLAGS+=" ${c_flags}"

    cd $build_directory
    $source_directory/glibc-${package_version}/configure \
        --prefix=/usr \
        --disable-werror \
        --enable-stack-protector=strong \
        --disable-nscd

    make ${make_flags}
}

handle_check() {
    cd $build_directory

    # There are expected failures in the testsuite
    # This means that for now we can not trust the
    # result value of the testsuite
    # For now just run it and ignore the outcome.
    make ${make_flags} -k check || true
}

handle_package() {
    cd $build_directory

    make DESTDIR=$package_directory install
    sed '/RTLDLIST=/s@/usr@@g' -i $package_directory/usr/bin/ldd

    mkdir -p $package_directory/etc
    cp $source_directory/ld.so.conf $package_directory/etc
    cp $source_directory/nsswitch.conf $package_directory/etc
}

handle_post_install() {
    # TODO: Work out locales somehow. For now just assume C and US english.
    localedef -i C -f UTF-8 C.UTF-8
    localedef -i en_US -f ISO-8859-1 en_US
    localedef -i en_US -f UTF-8 en_US.UTF-8
}
