//
//  ContentView.swift
//  ButtonBGAnimation
//
//  Created by Николай Игнатов on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var performAnimation = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        }  label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .buttonStyle(CustomButtonStyle())
    }
}

struct CustomButtonStyle: PrimitiveButtonStyle {
    @State private var isAnimating = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(.gray)
                .opacity(isAnimating ? 0.1 : .zero)
                .frame(width: 100, height: 100)
            
            configuration.label
                .foregroundStyle(.blue)
                .scaleEffect(isAnimating ? 0.86 : 1.0)
                .frame(width: 80, height: 80)
            
        }
        .onTapGesture {
            configuration.trigger()
            withAnimation(.interactiveSpring(duration: 0.22)) {
                isAnimating = true
            } completion: {
                isAnimating = false
            }
        }
    }
}

#Preview {
    ContentView()
}
