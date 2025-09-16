//
//  ShapesApp.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import SwiftUI

@main
struct ShapesApp: App {
    private var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    var body: some Scene {
        WindowGroup {
            if isRunningTests {
                Text("Test Host")
            } else {
                ContentView()
            }
        }
    }
}
