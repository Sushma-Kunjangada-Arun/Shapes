//
//  PathChecker.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import SwiftUI

struct PathChecker {
    func isOnStroke(_ point: CGPoint,
                    shape: ShapeType,
                    in rect: CGRect,
                    lineWidth: CGFloat = 24,
                    tolerance: CGFloat = 18) -> Bool {
        let path = shape.path(in: rect)
        let stroked = path.cgPath.copy(strokingWithWidth: lineWidth + tolerance,
                                       lineCap: .round,
                                       lineJoin: .round,
                                       miterLimit: 10)
        return stroked.contains(point)
    }
    
    func isNearVertex(_ point: CGPoint,
                      shape: ShapeType,
                      in rect: CGRect,
                      radius: CGFloat = 28) -> Bool {
        shape.vertices(in: rect).contains { v in
            hypot(point.x - v.x, point.y - v.y) <= radius
        }
    }
}
