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
public class ColorObject: ObservableObject {
    
    // the slider value (0->nColors)
    @Published public var value: Double = 0.0
    // the number of colors to display
    @Published public var nColors: Int = 1
    // saturation setting
    @Published public var saturation: Double = 1.0
    // brightness setting
    @Published public var brightness: Double = 1.0
    // to allow dragging the slider around the screen
    @Published public var isDraggable: Bool = true
    
    // the current color
    @Published public var color = Color.white

    // set as grayscale or not
    public var grayScale = false
    
    // the thickness of the bar of each color in the slider.
    public var bandSize = 1

    // default 100 colors, not gray scale and is draggable
    public init(nColors: Int = 100, grayScale: Bool = false, isDraggable: Bool = true) {
        self.grayScale = grayScale
        self.nColors = nColors
        self.isDraggable = isDraggable
        if grayScale {
            self.saturation = 0.0
        }
    }

    // the color array for the gradient
    public var colors: [Color] {
        guard nColors > 0 else { return [] }
        let delta: Double = 1/Double(nColors).rounded(.up)
        let hues: [Double] = Array(stride(from: delta, to: 1.0, by: delta))
        var colorSet = [Color]()
        for hue in hues {
            for _ in 0..<self.bandSize {
                colorSet.append(Color(hue: grayScale ? 0 : hue, saturation: saturation, brightness: grayScale ? hue : brightness))
            }
        }
        return whiteBlock + colorSet.reversed() + blackBlock
    }
    
    public var whiteBlock: [Color] {
         Array(repeating: Color.white, count: bandSize)
    }
    
    public var blackBlock: [Color] {
         Array(repeating: Color.black, count: bandSize)
    }
    
    // the color gradient for the background
    public var colorGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }
    
    // the slider color range of values
    public var colorRange: ClosedRange<Double> {
        let n = colors.count - 1
        return 0...(n > 0 ? Double(n) : 1.0)
    }
    
}
