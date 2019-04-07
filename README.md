# swiftLibconsensus

Swift wrapper around [`libbitcoinconsensus`](https://github.com/bitcoin/bitcoin/blob/master/doc/shared-libraries.md).

Make and install `libbitcoinconsensus`:
```shell
pushd bitcoin
./autogen.sh
./configure --with-libs=yes --with-gui=no --with-daemon=no --with-utils=no --disable-tests --disable-bench
make -j6
make install
```

Inside your projects `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/fanquake/swiftLibconsensus", .branch("master"))
],
```
