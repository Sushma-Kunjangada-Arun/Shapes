//
//  NoopHaptics.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import Foundation

struct NoopHaptics: HapticsProviding {
    func startContinuous() {}
    func stopContinuous() {}
    func pulse(strong: Bool) {}
}
