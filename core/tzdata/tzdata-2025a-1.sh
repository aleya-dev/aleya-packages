# Maintainer: Robin 'Ruadeil' Degen <mail@ruadeil.lgbt>

url="https://www.iana.org/time-zones"
licenses=('LicenseRef-tz')
dependencies=("glibc/2.41-1")
build_dependencies=()
sources=(
    "https://data.iana.org/time-zones/releases/tzdata${package_version}.tar.gz"
)
sha256sums=(
    "4d5fcbc72c7c450ebfe0b659bd0f1c02fbf52fd7f517a9ea13fe71c21eb5f0d0"
)
package_options=()

handle_package() {
    cd $source_directory

    ZONEINFO=$package_directory/usr/share/zoneinfo
    mkdir -p $ZONEINFO

    for tz in etcetera southamerica northamerica europe africa antarctica  \
            asia australasia backward; do
        zic -L /dev/null   -d $ZONEINFO       ${tz}
        zic -L /dev/null   -d $ZONEINFO/posix ${tz}
        zic -L leapseconds -d $ZONEINFO/right ${tz}
    done

    cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
    zic -d $ZONEINFO -p Europe/Amsterdam
}
