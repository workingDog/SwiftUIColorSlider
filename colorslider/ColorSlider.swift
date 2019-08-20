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
    
    var body: some View {
        Slider(value: $colorObject.value, in: 0...(colorObject.nColors > 0 ? colorObject.nColors : 1), step: 1)
            .background(LinearGradient(gradient: Gradient(colors: colorObject.colors), startPoint: .leading, endPoint: .trailing))
    }
     
}

#if DEBUG
struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(colorObject: ColorObject())
    }
}
#endif
