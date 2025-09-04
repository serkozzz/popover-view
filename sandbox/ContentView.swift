//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 15.07.2025.
//

import SwiftUI
import Combine



struct ContentView : View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0...30, id: \.self) { i in
                    Cell(cellText: "Hello \(i)")
                }
            }
        }
    }
    
}

struct Cell: View {
    var cellText: String
    @State private var showPopover: Bool = false
    @State private var popoverText: String = "Hello"
    
    var body: some View {
        HStack {
            Text(cellText)
            Button("info") {
                showPopover = true
            }
            
            .customPopover(show: $showPopover,
                           text: popoverText,
                           maxWidth: 300)
        }
        // .frame(maxWidth: .infinity)
        .buttonStyle(BorderlessButtonStyle())
        .task {
            while (true) {
                try? await Task.sleep(for: .seconds(2))
                popoverText = "Hello"
                for i in (0...Int.random(in: 1...10)) {
                    popoverText += "It's me"
                }
            }
        }
        
    }
}


#Preview {
    ContentView()
}

