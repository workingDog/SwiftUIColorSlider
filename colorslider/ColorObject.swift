//
//  ColorObject.swift
//  colorslider
//
//  Created by Ringo Wathelet on 2019/08/20.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import Foundation
import SwiftUI


final class ColorObject: ObservableObject {
    
    // the slider value (0->nColors)
    @Published var value: Double = 0.0
    // the number of colors to display
    @Published var nColors: Double = 1.0
    // saturation setting
    @Published var saturation: Double = 1.0
    // brightness setting
    @Published var brightness: Double = 1.0
    
    // the current color
    var color: Color {
        return colors.isEmpty ? Color.clear : colors[Int(value)]
    }
    
    // default 100 colors
    init(nColors: Double = 100) {
        self.nColors = nColors
    }
    
    // the color array of the gradient
    var colors: [Color] {
        guard nColors > 0 else { return [] }
        let delta: Double = (1/nColors * nColors).rounded(.up) / nColors
        let hues: [Double] = Array(stride(from: delta, to: 1.0, by: delta))
        let colorSet = hues.map({ hue -> Color in
            Color(hue: hue, saturation: saturation, brightness: brightness)
        }).reversed()
        return [Color.white] + colorSet + [Color.black]
    }
 
}
