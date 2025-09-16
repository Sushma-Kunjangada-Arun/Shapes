//
//  ShapeViewModel.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import SwiftUI
import Combine

final class ShapeViewModel: ObservableObject {
    @Published var selected: ShapeType = .circle
    @Published var onPath: Bool = false

    private let checker = PathChecker()
    private let haptics: HapticsProviding
    private let tone: ToneProviding

    private static var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    init(haptics: HapticsProviding? = nil,
         tone: ToneProviding? = nil) {
        if let h = haptics {
            self.haptics = h
        } else {
            self.haptics = Self.isRunningTests ? NoopHaptics() : HapticsService()
        }
        if let t = tone {
            self.tone = t
        } else {
            self.tone = Self.isRunningTests ? NoopTone() : ToneService()
        }
    }

    func update(point: CGPoint, in rect: CGRect) {
        let wasOn = onPath
        onPath = checker.isOnStroke(point, shape: selected, in: rect)

        if onPath && !wasOn {
            haptics.startContinuous()
            haptics.pulse(strong: false)
            tone.start(frequency: 660, gain: 0.08)

            UIAccessibility.post(notification: .announcement,
                                 argument: "On path")

        } else if !onPath && wasOn {
            haptics.stopContinuous()
            tone.stop()


            UIAccessibility.post(notification: .announcement,
                                 argument: "Off path")
        }

        if onPath && checker.isNearVertex(point, shape: selected, in: rect) {
            haptics.pulse(strong: true)
            tone.nudgePitch(to: 880, duration: 0.25)
        }
    }

    func endTouch() {
        if onPath {
            haptics.stopContinuous()
            tone.stop()

            UIAccessibility.post(notification: .announcement,
                                 argument: "Touch ended")
        }
        onPath = false
    }
}
