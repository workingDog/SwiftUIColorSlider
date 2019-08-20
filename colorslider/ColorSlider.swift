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
    
    @ObservedObject var colorObject: ColorObject
    
    var width: CGFloat
    var height: CGFloat
    var alignment: Alignment = .center
    
    var body: some View {
        Slider(value: $colorObject.value, in: 0...(colorObject.nColors > 0 ? Double(colorObject.nColors) : 1.0), step: 1)
            .frame(width: width, height: height, alignment: alignment) // need to have the frame first
            .background(LinearGradient(gradient: Gradient(colors: colorObject.colors), startPoint: .leading, endPoint: .trailing))
    }
     
}

#if DEBUG
struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(colorObject: ColorObject(), width: 300, height: 40)
    }
}
#endif
