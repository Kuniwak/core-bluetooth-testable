// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "core-bluetooth-testable",
    platforms: [
        .iOS(.v13),
        .macOS(.v14),
        .watchOS(.v6),
        .visionOS(.v1),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "CoreBluetoothTestable",
            targets: ["CoreBluetoothTestable"]
        ),
        .library(
            name: "CoreBluetoothStub",
            targets: ["CoreBluetoothStub"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Kuniwak/swift-logger.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/Kuniwak/MirrorDiffKit.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "CoreBluetoothTestable",
            dependencies: [
                .product(name: "Logger", package: "swift-logger"),
                "MirrorDiffKit",
            ]
        ),
        .testTarget(
            name: "CoreBluetoothTestableTests",
            dependencies: [
                "CoreBluetoothTestable",
                "MirrorDiffKit",
            ]
        ),
        .target(
            name: "CoreBluetoothStub",
            dependencies: [
                "CoreBluetoothTestable",
                "MirrorDiffKit",
            ]
        )
    ]
)
