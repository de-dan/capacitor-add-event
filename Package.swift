// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorAddEvent",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorAddEvent",
            targets: ["CalendarPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "CalendarPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CalendarPlugin"),
        .testTarget(
            name: "CalendarPluginTests",
            dependencies: ["CalendarPlugin"],
            path: "ios/Tests/CalendarPluginTests")
    ]
)
