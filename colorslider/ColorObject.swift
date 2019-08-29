//
//  ColorObject.swift
//  colorslider
//
//  Created by Ringo Wathelet on 2019/08/20.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import Foundation
import SwiftUI

/**
 * the ColorSlider companion observable object
 */
final class ColorObject: ObservableObject {
    
    // the slider value (0->nColors)
    @Published var value: Double = 0.0
    // the number of colors to display
    @Published var nColors: Int = 1
    // saturation setting
    @Published var saturation: Double = 1.0
    // brightness setting
    @Published var brightness: Double = 1.0
    // to allow dragging the slider around the screen
    @Published var isDraggable: Bool = true

    // set as grayscale or not
    var grayScale = false
    
    // the thickness of the bar of each color in the slider.
    var blockSize = 1
    
    // the current color
    var color: Color {
        return colors.isEmpty ? Color.clear : colors[Int(value)]
    }
    
    // default 100 colors, not gray scale and is draggable
    init(nColors: Int = 100, grayScale: Bool = false, isDraggable: Bool = true) {
        self.grayScale = grayScale
        self.nColors = nColors
        self.isDraggable = isDraggable
        if grayScale {
            self.saturation = 0.0
        }
    }
    
    // the color array for the gradient
    var colors: [Color] {
        guard nColors > 0 else { return [] }
        let delta: Double = 1/Double(nColors).rounded(.up)
        let hues: [Double] = Array(stride(from: delta, to: 1.0, by: delta))
        var temp = [Color]()
        for hue in hues {
            for _ in 0..<self.blockSize {
                temp.append(Color(hue: grayScale ? 0 : hue, saturation: saturation, brightness: grayScale ? hue : brightness))
            }
        }
        let colorSet = temp.reversed()
        return whiteBlock + colorSet + blackBlock
    }
    
    var whiteBlock: [Color] {
         Array(repeating: Color.white, count: blockSize)
    }
    
    var blackBlock: [Color] {
         Array(repeating: Color.black, count: blockSize)
    }
    
    // the color gradient for the background
    var colorGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }
    
    // the slider color range of values
    var colorRange: ClosedRange<Double> {
        let n = colors.count - 1
        return 0...(n > 0 ? Double(n) : 1.0)
    }
    
}
