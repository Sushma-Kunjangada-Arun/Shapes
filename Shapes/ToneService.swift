//
//  ToneService.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import AVFoundation

protocol ToneProviding {
    func start(frequency: Double, gain: Float)
    func stop()
    func setFrequency(_ frequency: Double)
    func nudgePitch(to frequency: Double, duration: TimeInterval)
}

final class ToneService: ToneProviding {
    private let engine = AVAudioEngine()
    private var source: AVAudioSourceNode?
    private var sampleRate: Double = 44100
    private var theta: Double = 0
    private var isRunning = false

    private var currentFreq: Double = 660
    private var baseFreq: Double = 660
    private var currentGain: Float = 0.08
    private var revertTimer: Timer?

    init() {
        sampleRate = engine.outputNode.outputFormat(forBus: 0).sampleRate
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    func start(frequency: Double = 660, gain: Float = 0.08) {
        guard !isRunning else { return }
        baseFreq = frequency
        currentFreq = frequency
        currentGain = gain

        let format = engine.outputNode.inputFormat(forBus: 0)
        let src = AVAudioSourceNode { [weak self] _, _, frameCount, audioBufferList -> OSStatus in
            guard let self else { return noErr }
            let abl = UnsafeMutableAudioBufferListPointer(audioBufferList)
            let step = 2.0 * Double.pi * self.currentFreq / self.sampleRate

            for frame in 0..<Int(frameCount) {
                let sample = Float(sin(self.theta)) * self.currentGain
                self.theta += step
                if self.theta > 2.0 * Double.pi { self.theta -= 2.0 * Double.pi }
                for buf in abl {
                    let ptr = buf.mData!.assumingMemoryBound(to: Float.self)
                    ptr[frame] = sample
                }
            }
            return noErr
        }

        engine.attach(src)
        engine.connect(src, to: engine.mainMixerNode, format: format)
        do {
            try engine.start()
            source = src
            isRunning = true
        } catch {
            source = nil
            isRunning = false
        }
    }

    func stop() {
        guard isRunning else { return }
        engine.stop()
        if let s = source { engine.detach(s) }
        source = nil
        isRunning = false
        revertTimer?.invalidate()
        revertTimer = nil
        currentFreq = baseFreq
    }

    func setFrequency(_ frequency: Double) {
        currentFreq = frequency
    }

    func nudgePitch(to frequency: Double, duration: TimeInterval) {
        guard isRunning else { return }
        setFrequency(frequency)
        revertTimer?.invalidate()
        revertTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.setFrequency(self.baseFreq)
        }
    }
}

