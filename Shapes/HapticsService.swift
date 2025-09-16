//
//  HapticsService.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import CoreHaptics

protocol HapticsProviding {
    func startContinuous()
    func stopContinuous()
    func pulse(strong: Bool)
}

final class HapticsService: HapticsProviding {
    private var engine: CHHapticEngine?
    private var supported = false
    private var player: CHHapticAdvancedPatternPlayer?

    init() {
        supported = CHHapticEngine.capabilitiesForHardware().supportsHaptics
        guard supported else { return }
        do {
            engine = try CHHapticEngine()
            engine?.stoppedHandler = { [weak self] _ in
                try? self?.engine?.start()
            }
            engine?.resetHandler = { [weak self] in
                try? self?.engine?.start()
            }
            try engine?.start()
        } catch {
            supported = false
        }
    }

    func startContinuous() {
        guard supported, let engine else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.25)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event = CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [intensity, sharpness],
                                  relativeTime: 0,
                                  duration: 60.0)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            player = try engine.makeAdvancedPlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
        }
    }

    func stopContinuous() {
        guard supported else { return }
        try? player?.stop(atTime: 0)
        player = nil
    }

    func pulse(strong: Bool) {
        guard supported, let engine else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: strong ? 1.0 : 0.4)
        let sharp = CHHapticEventParameter(parameterID: .hapticSharpness, value: strong ? 0.8 : 0.3)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharp], relativeTime: 0)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let p = try engine.makePlayer(with: pattern)
            try p.start(atTime: 0)
        } catch {
        }
    }
}
