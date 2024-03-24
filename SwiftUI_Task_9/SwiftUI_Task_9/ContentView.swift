//
//  ContentView.swift
//  SwiftUI_Task_9
//
//  Created by pavel mishanin on 24/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var position: CGSize = .zero
    
    var body: some View {
        let circleWidth: CGFloat = 150
        
        ZStack {
            Color.white
            
            Rectangle()
                .fill(.radialGradient(
                    colors: [.yellow, .red],
                    center: .center,
                    startRadius: 70,
                    endRadius: circleWidth
                ))
                .mask {
                    Canvas { context, size in
                        
                        context.addFilter(.alphaThreshold(min: 0.6, color:.red))
                        
                        context.addFilter(.blur(radius: 10))
                        
                        context.drawLayer { ctx in
                            
                            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                            
                            let shapeOne = ctx.resolveSymbol(id: 1)!
                            ctx.draw(shapeOne, at: center)
                            
                            let shapeTwo = ctx.resolveSymbol(id: 2)!
                            ctx.draw(shapeTwo, at: center)
                            
                        }
                    } symbols: {
                        
                        Circle()
                            .frame(width: circleWidth, height: circleWidth)
                            .tag(1)
                        
                        Circle()
                            .frame(width: circleWidth, height: circleWidth)
                            .offset(position)
                            .tag(2)
                    }
                    
                }
            
            Image(systemName: "cloud.sun.rain.fill")
                .resizable()
                .foregroundStyle(Color.white)
                .symbolRenderingMode(.hierarchical)
                .frame(width: circleWidth/2, height: circleWidth/2)
                .offset(position)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture()
                .onChanged({ value in
                    setPosition(value.translation)
                })
                .onEnded({ _ in
                    setPosition(.zero)
                })
        )
    }
    
    private func setPosition(_ position: CGSize) {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            self.position = position
        }
    }
    
}
