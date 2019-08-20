//
//  ContentView.swift
//  colorslider
//
//  Created by Ringo Wathelet on 2019/08/19.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

/**
 * demo of a color slider
 */
struct ContentView: View {

    // the color slider value (0->100)
    @State var value = Float(0)
    // the color array for the gradient
    @State var colors = [Color]()
    
    
    var body: some View {
        VStack {
            ColorSlider(value: $value, colors: $colors, saturation: 1, brightness: 1)
                .cornerRadius(25)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 1).foregroundColor(Color.black))
                .frame(width: CGFloat(300), height: CGFloat(40), alignment: .center)
            Text("\(value)")
            Text(getColorTxt()).foregroundColor(getColor() == .white ? .black : getColor())
        }
    }
    
    func getColorTxt() -> String {
        colors.isEmpty ? "" : String(colors[Int(value)].description)
    }
    
    func getColor() -> Color {
        colors.isEmpty ? Color.clear : colors[Int(value)]
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
