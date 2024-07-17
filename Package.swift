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
        .package(url: "https://github.com/Kuniwak/swift-logger.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Kuniwak/MirrorDiffKit.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "CoreBluetoothTestable",
            dependencies: [
                .product(name: "Logger", package: "swift-logger"),
                "MirrorDiffKit",
            ],
            swiftSettings: SwiftSetting.allCases
        ),
        .testTarget(
            name: "CoreBluetoothTestableTests",
            dependencies: [
                "CoreBluetoothTestable",
                "MirrorDiffKit",
            ],
            swiftSettings: SwiftSetting.allCases
        ),
        .target(
            name: "CoreBluetoothStub",
            dependencies: [
                "CoreBluetoothTestable",
                "MirrorDiffKit",
            ],
            swiftSettings: SwiftSetting.allCases
        )
    ]
)

extension SwiftSetting {
    /// Forward-scan matching for trailing closures
    /// - Version: Swift 5.3
    /// - Since: SwiftPM 5.8
    /// - SeeAlso: [SE-0286: Forward-scan matching for trailing closures](https://github.com/apple/swift-evolution/blob/main/proposals/0286-forward-scan-trailing-closures.md)
    static let forwardTrailingClosures: Self = .enableUpcomingFeature("ForwardTrailingClosures")
    /// Introduce existential `any`
    /// - Version: Swift 5.6
    /// - Since: SwiftPM 5.8
    /// - SeeAlso: [SE-0335: Introduce existential `any`](https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md)
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny")
    /// Regex Literals
    /// - Version: Swift 5.7
    /// - Since: SwiftPM 5.8
    /// - SeeAlso: [SE-0354: Regex Literals](https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md)
    static let bareSlashRegexLiterals: Self = .enableUpcomingFeature("BareSlashRegexLiterals")
    /// Concise magic file names
    /// - Version: Swift 5.8
    /// - Since: SwiftPM 5.8
    /// - SeeAlso: [SE-0274: Concise magic file names](https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md)
    static let conciseMagicFile: Self = .enableUpcomingFeature("ConciseMagicFile")
    /// Importing Forward Declared Objective-C Interfaces and Protocols
    /// - Version: Swift 5.9
    /// - Since: SwiftPM 5.9
    /// - SeeAlso: [SE-0384: Importing Forward Declared Objective-C Interfaces and Protocols](https://github.com/apple/swift-evolution/blob/main/proposals/0384-importing-forward-declared-objc-interfaces-and-protocols.md)
    static let importObjcForwardDeclarations: Self = .enableUpcomingFeature("ImportObjcForwardDeclarations")
    /// Remove Actor Isolation Inference caused by Property Wrappers
    /// - Version: Swift 5.9
    /// - Since: SwiftPM 5.9
    /// - SeeAlso: [SE-0401: Remove Actor Isolation Inference caused by Property Wrappers](https://github.com/apple/swift-evolution/blob/main/proposals/0401-remove-property-wrapper-isolation.md)
    static let disableOutwardActorInference: Self = .enableUpcomingFeature("DisableOutwardActorInference")
    /// Deprecate `@UIApplicationMain` and `@NSApplicationMain`
    /// - Version: Swift 5.10
    /// - Since: SwiftPM 5.10
    /// - SeeAlso: [SE-0383: Deprecate `@UIApplicationMain` and `@NSApplicationMain`](https://github.com/apple/swift-evolution/blob/main/proposals/0383-deprecate-uiapplicationmain-and-nsapplicationmain.md)
    static let deprecateApplicationMain: Self = .enableUpcomingFeature("DeprecateApplicationMain")
    /// Isolated default value expressions
    /// - Version: Swift 5.10
    /// - Since: SwiftPM 5.10
    /// - SeeAlso: [SE-0411: Isolated default value expressions](https://github.com/apple/swift-evolution/blob/main/proposals/0411-isolated-default-values.md)
    static let isolatedDefaultValues: Self = .enableUpcomingFeature("IsolatedDefaultValues")
    /// Strict concurrency for global variables
    /// - Version: Swift 5.10
    /// - Since: SwiftPM 5.10
    /// - SeeAlso: [SE-0412: Strict concurrency for global variables](https://github.com/apple/swift-evolution/blob/main/proposals/0412-strict-concurrency-for-global-variables.md)
    static let globalConcurrency: Self = .enableUpcomingFeature("GlobalConcurrency")
}

extension SwiftSetting {
    public static var allCases: [Self] {
        [
            .forwardTrailingClosures,
            .existentialAny,
            .bareSlashRegexLiterals,
            .conciseMagicFile,
            .importObjcForwardDeclarations,
            .disableOutwardActorInference,
            .deprecateApplicationMain,
            .isolatedDefaultValues,
            .globalConcurrency,
        ]
    }
}
