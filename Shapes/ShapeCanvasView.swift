//
//  ShapeCanvasView.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import SwiftUI

struct ShapeCanvasView: View {
    @ObservedObject var vm: ShapeViewModel
    @State private var dragPoint: CGPoint? = nil
    @State private var isVO = UIAccessibility.isVoiceOverRunning

    var body: some View {
        GeometryReader { geo in
            let rect = geo.frame(in: .local)
            let shapePath = vm.selected.path(in: rect)

            ZStack {
                // Visible outline
                shapePath
                    .stroke(
                        Color.primary.opacity(0.2),
                        style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round)
                    )

                if let p = dragPoint {
                    Circle()
                        .fill(vm.onPath ? Color.green : Color.red)
                        .frame(width: 18, height: 18)
                        .position(p)
                }
            }
            .contentShape(Rectangle())

            // Only attach DragGesture when VoiceOver is OFF
            .gesture(
                isVO ? nil :
                DragGesture(minimumDistance: 0)
                    .onChanged { g in
                        dragPoint = g.location
                        vm.update(point: g.location, in: rect)
                    }
                    .onEnded { _ in
                        dragPoint = nil
                        vm.endTouch()
                    }
            )

            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Tracing canvas")
            .accessibilityHint("Drag along the circle or square outline to hear a tone and feel haptics.")
            .accessibilityValue(vm.onPath ? "On the path" : "Off the path")
        }
        // Track VoiceOver on/off
        .onReceive(NotificationCenter.default.publisher(
            for: UIAccessibility.voiceOverStatusDidChangeNotification
        )) { _ in
            isVO = UIAccessibility.isVoiceOverRunning
        }
    }
}

