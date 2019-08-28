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
            ColorSlider(colorObject: colorObject, width: 300, height: 40, cornerRadius: 20)
            //  .rotationEffect(.degrees(90))
            Text("\(colorObject.value)")
            Text(String(colorObject.color.description)).foregroundColor(colorObject.color == .white ? .black : colorObject.color)
            Circle().frame(width: 50, height: 50).overlay(Circle().stroke(Color.black,lineWidth: 1)).foregroundColor(colorObject.color)
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
