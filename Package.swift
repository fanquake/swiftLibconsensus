// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "swiftLibconsensus",
    products: [
        .library(
            name: "swiftLibconsensus",
            targets: ["swiftLibconsensus"]),
    ],
    dependencies: [],
    targets: [
        .systemLibrary(
            name: "libbitcoinconsensus",
            pkgConfig: "libbitcoinconsensus"),
        .target(
            name: "swiftLibconsensus",
            dependencies: ["libbitcoinconsensus"]),
        .testTarget(
            name: "swiftLibconsensusTests",
            dependencies: ["swiftLibconsensus"]),
    ]
)
