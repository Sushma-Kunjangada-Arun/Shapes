//
//  StatusChip.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/16/25.
//

import SwiftUI

struct StatusChip: View {
    let onPath: Bool
    private let maroon = Color(red: 160/255, green: 40/255,  blue: 60/255)
    private let rose   = Color(red: 220/255, green: 120/255, blue: 140/255)

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: onPath ? "checkmark.circle.fill" : "xmark.circle.fill")
                .imageScale(.large)
            Text(onPath ? "On Path" : "Off Path")
                .font(.headline.weight(.semibold))
        }
        .foregroundStyle(onPath ? maroon : rose)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            Capsule().fill((onPath ? maroon : rose).opacity(0.14))
        )
        .overlay(
            Capsule().strokeBorder(.white.opacity(0.6), lineWidth: 0.5)
        )
        .padding(.horizontal)
        .accessibilityLabel("Tracing status")
        .accessibilityValue(onPath ? "On path" : "Off path")
    }
}
