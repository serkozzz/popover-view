//
//  CustomPopover.swift
//  sandbox
//
//  Created by Sergey Kozlov on 01.09.2025.
//
import SwiftUI

struct CustomPopover: ViewModifier {
    


    @Binding var show: Bool
    @State var centerOfPresentingInGlobals: CGPoint?
    var text: String
    var maxWidth: CGFloat?
    
    var indent: CGFloat = 18
    var height: CGFloat = 100
    
    
    func body(content: Content) -> some View {
        if (show) {
            content
                .readCenter()
                .onPreferenceChange(CenterPreferenceKey.self) { value in
                    centerOfPresentingInGlobals = value
                }
                .overlay {
                    ZStack {
                        if let centerOfPresentingInGlobals {
                            
                            backAreaForTouches(centerOfPresentingInGlobals)
                            
                            let sign: CGFloat = centerOfPresentingInGlobals.y - (height + indent) > 0 ? -1 : 1
                            ZStack   {
                                Text(text)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.black)
                                    }
                                    .frame(maxWidth: maxWidth)
                                    .contentShape(Rectangle())
                                    .onTapGesture { }
                                    .offset( y: sign * (height / 2 + indent))
                            }
                            .zIndex(1000)
                        }
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.98)))
                }
        }
        else {
            content
        }
    }
    
    
    private func backAreaForTouches(_ centerOfPresentingInGlobals: CGPoint) -> some View {
        let globalScreenCenter = CGPoint(
            x: UIScreen.main.bounds.midX,
            y: UIScreen.main.bounds.midY)
        
        let backAreaOffset = CGPoint(x: globalScreenCenter.x - centerOfPresentingInGlobals.x,
                                     y: globalScreenCenter.y - centerOfPresentingInGlobals.y)
        
        return Rectangle()
            .fill(Color.red.opacity(0.001))
              .frame(width: UIScreen.main.bounds.width,
                     height: UIScreen.main.bounds.height)
              .offset(x: backAreaOffset.x, y: backAreaOffset.y)
              .onTapGesture {
                  withAnimation(.easeOut) { show = false }
              }
              .zIndex(999)
    }
}

extension View {
    
    func customPopover(show: Binding<Bool>, text: String, maxWidth: CGFloat? = nil) -> some View {
        self.modifier(CustomPopover(show: show, text: text, maxWidth: maxWidth))
    }
}


#Preview {
    ContentView()
}
