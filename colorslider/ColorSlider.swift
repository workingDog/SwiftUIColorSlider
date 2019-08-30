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
    
    var cornerRadius = CGFloat(0)
    var lineWidth = CGFloat(0)
    var borderColor = Color.black
    
    @State var prev = CGSize.zero
    @State var pos = CGSize.zero
    @State var flag = true
    
    var editing: (Bool) -> Void
    
    init(colorObject: ColorObject, width: CGFloat, height: CGFloat, cornerRadius: CGFloat,
         lineWidth: CGFloat, borderColor: Color, onEditing: @escaping (Bool) -> Void) {
        self.colorObject = colorObject
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.borderColor = borderColor
        self.editing = onEditing
    }

    var body: some View {
        
        let drag = DragGesture()
            .onChanged { value in
                self.pos = CGSize(width: value.translation.width + self.prev.width, height: value.translation.height + self.prev.height)
        }
        .onEnded { value in
            self.pos = CGSize(width: value.translation.width + self.prev.width, height: value.translation.height + self.prev.height)
            self.prev = self.pos
        }
        
        return Slider(value: Binding<Double>(
            get: { self.colorObject.value }, set: { self.sliderChanged($0) }),
                      in: colorObject.colorRange, step: 1) { _ in
                        if self.colorObject.isDraggable {
                            self.flag = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.flag = true
                            }
                        }
        }
        .frame(width: width, height: height)
        .background(colorObject.colorGradient)
        .mask(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth).foregroundColor(borderColor))
        .accentColor(.clear)
        .offset(x: self.colorObject.isDraggable ? self.pos.width : 0, y: self.colorObject.isDraggable ? self.pos.height : 0)
        .animation(.linear(duration: 0.3))
        .gesture(self.colorObject.isDraggable && self.flag ? drag : nil)
    }
    
    private func sliderChanged(_ value: Double) {
        colorObject.value = value
        colorObject.color = colorObject.colors.isEmpty ? Color.clear : colorObject.colors[Int(value)]
    }
    
}

#if DEBUG
struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(colorObject: ColorObject(), width: 300, height: 40)
    }
}
#endif
