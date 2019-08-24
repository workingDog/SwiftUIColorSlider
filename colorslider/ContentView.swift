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
    
    @ObservedObject var colorObject = ColorObject()
      
    var body: some View {
        VStack {
            ColorSlider(colorObject: colorObject, width: 300, height: 40)
            Text("\(colorObject.value)")
            Text(String(colorObject.color.description)).foregroundColor(colorObject.color == .white ? .black : colorObject.color)
        }
    }
     
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
