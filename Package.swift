// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NeumorphicView",
    platforms: [.macOS(.v10_12)],
    products: [
        .library(
            name: "NeumorphicView",
            targets: ["NeumorphicView"]),
    ],
    dependencies: [],
    targets: [.target(name: "NeumorphicView", dependencies: [], path: "NeumorphicView/NeumorphicView")]
)
