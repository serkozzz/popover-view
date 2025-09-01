//
//  CustomPopover.swift
//  sandbox
//
//  Created by Sergey Kozlov on 01.09.2025.
//
import SwiftUI

struct PopoverView: ViewModifier {
    
    var indent: CGFloat = 18
    var height: CGFloat = 100
    var width: CGFloat = 200
    @Binding var show: Bool
    @State var buttonCenterInGlobals: CGPoint?
    
    
    
    func body(content: Content) -> some View {
        if (show) {
            content
                .readCenter()
                .onPreferenceChange(CenterPreferenceKey.self) { value in
                    buttonCenterInGlobals = value
                }
                .overlay {
                    ZStack {
                        if let buttonCenterInGlobals {
                            let sign: CGFloat = buttonCenterInGlobals.y - (height + indent) > 0 ? -1 : 1
                            ZStack   {
                                Rectangle().fill(Color.black)
                                    .frame(width: width, height: height)
                                    .offset( y: sign * (height / 2 + indent))
                            }
                        }
                    }
                }
        }
        else {
            content
        }
    }
}

extension View {
    
    func customPopover(show: Binding<Bool>) -> some View {
        self.modifier(PopoverView(show: show))
    }
}


#Preview {
    ContentView()
}
