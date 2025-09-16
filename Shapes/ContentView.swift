//
//  ContentView.swift
//  Shapes
//
//  Created by Sushma Kunjangada Arun on 9/15/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ShapeViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ShapeSelector(selection: $vm.selected)
                    .padding(.horizontal)
                    .accessibilityLabel("Select shape")
                    .accessibilityHint("Choose a shape to trace")

                // Status label updates while tracing
                StatusChip(onPath: vm.onPath)

                ShapeCanvasView(vm: vm)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
            }
            .navigationTitle("Shapes")
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 120/255, green: 20/255, blue: 40/255),   // deep maroon
                        Color(red: 80/255, green: 50/255, blue: 140/255)    // purple-blue mix
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ContentView()
}
