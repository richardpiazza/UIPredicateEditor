// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UIPredicateEditor",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v18),
    .macCatalyst(.v18),
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "UIPredicateEditor",
      targets: ["UIPredicateEditor"],
    ),
    .library(
      name: "PredicateEditor",
      targets: [
        "UIPredicateEditor",
        "PredicateEditor",
      ],
    ),
  ],
  targets: [
    .target(
      name: "UIPredicateEditor",
      resources: [.process("Resources")],
    ),
    .target(
      name: "PredicateEditor",
      dependencies: [
        "UIPredicateEditor",
      ],
    ),
    .testTarget(
      name: "UIPredicateEditorTests",
      dependencies: ["UIPredicateEditor"],
    ),
  ],
)
