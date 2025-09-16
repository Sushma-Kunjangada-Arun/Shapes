//
//  ShapeType.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import SwiftUI

enum ShapeType: String, CaseIterable, Identifiable {
    case circle = "Circle"
    case square = "Square"
    
    var id: String { rawValue }
    
    func path(in rect: CGRect) -> Path {
        let size = min(rect.width, rect.height) * 0.8
        let origin = CGPoint(x: rect.midX - size / 2,
                             y: rect.midY - size / 2)
        switch self {
        case .circle:
            return Path(ellipseIn: CGRect(origin: origin,
                                          size: CGSize(width: size, height: size)))
        case .square:
            return Path(CGRect(origin: origin,
                               size: CGSize(width: size, height: size)))
        }
    }
    
    // Important points
    func vertices(in rect: CGRect) -> [CGPoint] {
        let size = min(rect.width, rect.height) * 0.8
        let frame = CGRect(x: rect.midX - size / 2,
                           y: rect.midY - size / 2,
                           width: size,
                           height: size)
        
        switch self {
        case .circle:
            return [
                CGPoint(x: frame.midX, y: frame.minY),
                CGPoint(x: frame.maxX, y: frame.midY),
                CGPoint(x: frame.midX, y: frame.maxY),
                CGPoint(x: frame.minX, y: frame.midY)
            ]
        case .square:
            return [
                frame.origin,
                CGPoint(x: frame.maxX, y: frame.minY),
                CGPoint(x: frame.maxX, y: frame.maxY),
                CGPoint(x: frame.minX, y: frame.maxY)
            ]
        }
    }
}
