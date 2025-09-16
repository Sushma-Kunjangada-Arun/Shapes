//
//  ShapeSelector.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import SwiftUI

struct ShapeSelector: View {
    @Binding var selection: ShapeType

    private let maroon = Color(red: 160/255, green: 40/255,  blue: 60/255)

    var body: some View {
        HStack(spacing: 8) {
            ForEach(ShapeType.allCases) { s in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selection = s }
                } label: {
                    Text(s.rawValue)
                        .font(.body.weight(.semibold))
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(selection == s ? .white : .black.opacity(0.75))
                }
                .buttonStyle(.plain)
                .background(
                    Capsule().fill(selection == s ? maroon : Color.white.opacity(0.22))
                )
                .overlay(
                    Capsule().strokeBorder(selection == s ? .white.opacity(0.9) : .clear, lineWidth: 1)
                )
                .shadow(color: .black.opacity(selection == s ? 0.12 : 0.0), radius: 8, y: 2)
            }
        }
        .padding(6)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
