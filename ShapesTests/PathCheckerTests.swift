//
//  PathCheckerTests.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import XCTest
@testable import Shapes

final class PathCheckerTests: XCTestCase {
    func testCircleHit() {
        let checker = PathChecker()
        let rect = CGRect(x: 0, y: 0, width: 300, height: 300)

        let nearStroke = CGPoint(x: 150, y: 45)
        XCTAssertTrue(checker.isOnStroke(nearStroke, shape: .circle, in: rect),
                      "Expected point near the circle stroke to be detected as on-path")

        let far = CGPoint(x: 10, y: 10)
        XCTAssertFalse(checker.isOnStroke(far, shape: .circle, in: rect),
                       "Expected far point to be off-path")
    }

    func testSquareHit() {
        let checker = PathChecker()
        let rect = CGRect(x: 0, y: 0, width: 300, height: 300)

        let nearEdge = CGPoint(x: 150, y: 45)
        XCTAssertTrue(checker.isOnStroke(nearEdge, shape: .square, in: rect))

        let center = CGPoint(x: 150, y: 150)
        XCTAssertFalse(checker.isOnStroke(center, shape: .square, in: rect),
                       "Inside fill should be off-path since we test stroke proximity")
    }
    
    func testSquareVertexIsDetectedAsNearVertex() {
        let checker = PathChecker()
        let rect = CGRect(x: 0, y: 0, width: 300, height: 300)

        let vertices = ShapeType.square.vertices(in: rect)
        XCTAssertFalse(vertices.isEmpty, "Square should expose vertices")

        let corner = vertices[0]
        let near = CGPoint(x: corner.x + 6, y: corner.y + 6)
        let far  = CGPoint(x: corner.x + 60, y: corner.y + 60)

        XCTAssertTrue(checker.isNearVertex(near, shape: .square, in: rect),
                      "Point close to a corner should be near a vertex")
        XCTAssertFalse(checker.isNearVertex(far, shape: .square, in: rect),
                       "Far point should not be near a vertex")
    }

    func testCircleCardinalPointIsDetectedAsNearVertex() {
        let checker = PathChecker()
        let rect = CGRect(x: 0, y: 0, width: 300, height: 300)

        let points = ShapeType.circle.vertices(in: rect)
        XCTAssertFalse(points.isEmpty, "Circle should expose cardinal points")

        let p = points[0]
        let near = CGPoint(x: p.x + 4, y: p.y + 4)
        let far  = CGPoint(x: p.x + 80, y: p.y + 80)

        XCTAssertTrue(checker.isNearVertex(near, shape: .circle, in: rect))
        XCTAssertFalse(checker.isNearVertex(far, shape: .circle, in: rect))
    }
}
