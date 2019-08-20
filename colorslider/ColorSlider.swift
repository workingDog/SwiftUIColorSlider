//
//  ColorSlider.swift
//  colorslider
//
//  Created by Ringo Wathelet on 2019/08/19.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

/**
* a color slider view
*/
struct ColorSlider: View {
    
    // the value of the slider (0->1)
    @Binding<Float> var value: Float
    // the color array of the gradient (white + colors + black)
    @Binding<[Color]> var colors: [Color]

    @State var saturation: Double
    @State var brightness: Double
  
    
    var body: some View {
            Slider(value: $value, in: 0...1.0, step: 0.01)
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .onAppear(perform: loadColors)
    }
    
    func loadColors() {
        let hues: [Double] = Array(stride(from: 0.01, to: 1.0, by: 0.01))
        let colorSet = hues.map({ hue -> Color in
            Color(hue: hue, saturation: saturation, brightness: brightness)
        }).reversed()
        colors = [Color.white] + colorSet + [Color.black]
    }
   
}

//#if DEBUG
//struct ColorSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorSlider()
//    }
//}
//#endif
