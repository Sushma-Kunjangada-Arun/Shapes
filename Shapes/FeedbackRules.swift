//
//  FeedbackRules.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

struct FeedbackActions {
    var startHaptics = false
    var stopHaptics  = false
    var entryPulse   = false
    var strongPulse  = false
    var startTone    = false
    var stopTone     = false
    var nudgePitch   = false
}

extension FeedbackActions: Equatable {
    nonisolated static func == (lhs: FeedbackActions, rhs: FeedbackActions) -> Bool {
        lhs.startHaptics == rhs.startHaptics &&
        lhs.stopHaptics  == rhs.stopHaptics  &&
        lhs.entryPulse   == rhs.entryPulse   &&
        lhs.strongPulse  == rhs.strongPulse  &&
        lhs.startTone    == rhs.startTone    &&
        lhs.stopTone     == rhs.stopTone     &&
        lhs.nudgePitch   == rhs.nudgePitch
    }
}

@inline(__always)
func computeFeedback(previousOn: Bool, currentOn: Bool, nearVertex: Bool) -> FeedbackActions {
    var a = FeedbackActions()
    if currentOn && !previousOn {
        a.startHaptics = true; a.entryPulse = true; a.startTone = true
    } else if !currentOn && previousOn {
        a.stopHaptics = true; a.stopTone = true
    }
    if currentOn && nearVertex {
        a.strongPulse = true; a.nudgePitch = true
    }
    return a
}
