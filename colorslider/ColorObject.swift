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
    @Published var nColors: Int = 1
    // saturation setting
    @Published var saturation: Double = 1.0
    // brightness setting
    @Published var brightness: Double = 1.0
    
    let grayScale: Bool
    
    // the current color
    var color: Color {
        return colors.isEmpty ? Color.clear : colors[Int(value)]
    }
    
    // default 100 colors
    init(nColors: Int = 100, grayScale: Bool = false) {
        self.grayScale = grayScale
        self.nColors = nColors
        if grayScale {
            self.saturation = 0.0
        }
    }
    
    // the color array of the gradient
    var colors: [Color] {
        guard nColors > 0 else { return [] }
        let delta: Double = 1/Double(nColors).rounded(.up)
        let hues: [Double] = Array(stride(from: delta, to: 1.0, by: delta))
        let colorSet = hues.map({ hue -> Color in
            Color(hue: grayScale ? 0 : hue, saturation: saturation, brightness: grayScale ? hue : brightness)
        }).reversed()
        return [Color.white] + colorSet + [Color.black]
    }
    
}
