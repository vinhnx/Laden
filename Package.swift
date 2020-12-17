// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Laden",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Laden",
            targets: ["Laden"]),
    ],
    targets: [
        .target(
            name: "Laden",
            dependencies: [])
    ]
)
