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
      var cornerRadius = CGFloat(25)
      var lineWidth = CGFloat(1)
      var borderColor = Color.black
       
      @State var prev = CGSize.zero
      @State var pos = CGSize.zero
      
      var body: some View {
        
          let drag = DragGesture()
              .onChanged { value in
                  self.pos = CGSize(width: value.translation.width + self.prev.width, height: value.translation.height + self.prev.height)
          }
          .onEnded { value in
              self.pos = CGSize(width: value.translation.width + self.prev.width, height: value.translation.height + self.prev.height)
              self.prev = self.pos
          }
          
          return Slider(value: $colorObject.value, in: colorObject.colorRange, step: 1) { _ in
              if self.colorObject.isDraggable {
                  self.colorObject.flag = false
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                      self.colorObject.flag = true
                  }
              }
          }
          .frame(width: width, height: height, alignment: alignment)  // need to have the frame first
          .background(colorObject.colorGradient)  // need to have the background second
          .cornerRadius(cornerRadius)
          .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth).foregroundColor(borderColor))
          .offset(x: self.colorObject.isDraggable ? self.pos.width : 0, y: self.colorObject.isDraggable ? self.pos.height : 0)
          .gesture(self.colorObject.isDraggable && self.colorObject.flag ? drag : nil)
      }
    
}

#if DEBUG
struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(colorObject: ColorObject(), width: 300, height: 40)
    }
}
#endif
