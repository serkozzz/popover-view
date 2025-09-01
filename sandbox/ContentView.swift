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
                    Cell(text: "Hello \(i)")
                }
            }
        }
    }
    
}

struct Cell: View {
    var text: String
    @State private var showPopover: Bool = false
    
    
    var body: some View {
        HStack {
            Text(text)
            Button("info") {
                showPopover = true
            }

            .customPopover(show: $showPopover)
        }
       // .frame(maxWidth: .infinity)
        .buttonStyle(BorderlessButtonStyle())
        
    }
}


#Preview {
    ContentView()
}

