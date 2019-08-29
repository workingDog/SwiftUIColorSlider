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
    
    @ObservedObject var colorObject1 = ColorObject()
    @ObservedObject var colorObject2 = ColorObject()
    
    @State var slider1: ColorSlider?
    @State var slider2: ColorSlider?
      
    var body: some View {
        VStack (spacing: 20) {
            
            slider1
            Text("\(colorObject1.value)")
            Text(String(colorObject1.color.description)).foregroundColor(colorObject1.color == .white ? .black : colorObject1.color)
            Circle().frame(width: 50, height: 50).overlay(Circle().stroke(Color.black,lineWidth: 1)).foregroundColor(colorObject1.color)
            
            slider2
            Text("\(colorObject2.value)")
            Text(String(colorObject2.color.description)).foregroundColor(colorObject2.color == .white ? .black : colorObject2.color)
            Circle().frame(width: 50, height: 50).overlay(Circle().stroke(Color.black,lineWidth: 1)).foregroundColor(colorObject2.color)
            
        }.onAppear(perform: doSetup)
    }
     
    func doSetup() {
        // using the default ColorObject settings
        slider1 = ColorSlider(colorObject: colorObject1, width: 300, height: 40, cornerRadius: 20)
        
        // example of using the blockSize to modify the thickness of the color band
        colorObject2.nColors = 10
        colorObject2.blockSize = 10
        slider2 = ColorSlider(colorObject: colorObject2, width: 300, height: 40, cornerRadius: 20)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
