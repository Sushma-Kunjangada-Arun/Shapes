//
//  FeedbackRulesTests.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import XCTest
@testable import Shapes

final class FeedbackRulesTests: XCTestCase {

    func testEnterPathStartsContinuousAndTone() {
        let a = computeFeedback(previousOn: false, currentOn: true, nearVertex: false)
        XCTAssertEqual(a, FeedbackActions(startHaptics: true,
                                          stopHaptics: false,
                                          entryPulse:  true,
                                          strongPulse: false,
                                          startTone:   true,
                                          stopTone:    false,
                                          nudgePitch:  false))
    }

    func testLeavePathStopsContinuousAndTone() {
        let a = computeFeedback(previousOn: true, currentOn: false, nearVertex: false)
        XCTAssertTrue(a.stopHaptics)
        XCTAssertTrue(a.stopTone)
        XCTAssertFalse(a.entryPulse)
        XCTAssertFalse(a.strongPulse)
    }

    func testVertexWhileOnPathAddsStrongPulseAndPitchNudge() {
        let a = computeFeedback(previousOn: true, currentOn: true, nearVertex: true)
        XCTAssertTrue(a.strongPulse)
        XCTAssertTrue(a.nudgePitch)
    }
}
