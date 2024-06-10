// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "core-bluetooth-testable",
    platforms: [
        .iOS(.v14),
        .macOS(.v14),
        .watchOS(.v4),
        .visionOS(.v1),
        .tvOS(.v12),
    ],
    products: [
        .library(
            name: "CoreBluetoothTestable",
            targets: ["CoreBluetoothTestable"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Kuniwak/swift-logger", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "CoreBluetoothTestable",
            dependencies: [
                .product(name: "Logger", package: "swift-logger")
            ]
        ),
    ]
)
