//
//  NoopTone.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import Foundation

struct NoopTone: ToneProviding {
    func start(frequency: Double, gain: Float) {}
    func stop() {}
    func setFrequency(_ frequency: Double) {}
    func nudgePitch(to frequency: Double, duration: TimeInterval) {}
}
