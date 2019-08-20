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
    
    // the value of the slider (0->nColors)
    @Binding<Double> var value: Double
    // the color array of the gradient (white + colors + black)
    @Binding<[Color]> var colors: [Color]

    @State var saturation: Double
    @State var brightness: Double
    // the number of colors to display
    var nColors: Double


    var body: some View {
        Slider(value: $value, in: 0...(nColors > 0 ? nColors : 1), step: 1)
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .onAppear(perform: loadColors)
    }
    
    func loadColors() {
        guard nColors > 0 else { return }
        let val: Double = (1/nColors * nColors).rounded(.up) / nColors
        let hues: [Double] = Array(stride(from: val, to: 1.0, by: val))
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
