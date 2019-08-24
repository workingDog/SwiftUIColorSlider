//
//  ColoSlider2.swift
//  colorslider
//
//  Created by Ringo Wathelet on 2019/08/25.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

/**
 * a color slider view
 */
struct ColorSlider2: View {
      
      @ObservedObject var colorObject: ColorObject
      
      var width: CGFloat
      var height: CGFloat
      var alignment: Alignment = .center
      var cornerRadius = CGFloat(25)
      var lineWidth = CGFloat(1)
      var borderColor = Color.black
       
      @State var prev = CGSize.zero
      @State var pos = CGSize.zero
      
    
       enum DragState {
           case inactive
           case pressing
           case dragging(translation: CGSize)
           
           var translation: CGSize {
               switch self {
               case .inactive, .pressing:  return .zero
               case .dragging(let translation): return translation
               }
           }
           
           var isActive: Bool {
               switch self {
               case .inactive: return false
               case .pressing, .dragging: return true
               }
           }
           
           var isDragging: Bool {
               switch self {
               case .inactive, .pressing: return false
               case .dragging: return true
               }
           }
       }
       
    @GestureState var dragState = DragState.inactive
    @State var viewState = CGSize.zero
    
    
      var body: some View {
        
        let minDuration = 0.5
        let longPressDrag = LongPressGesture(minimumDuration: minDuration)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, transaction in
                switch value {
                // Long press begins.
                case .first(true):
                    print("====> pressing")
                    state = .pressing
                // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    print("====> dragging")
                    state = .dragging(translation: drag?.translation ?? .zero)
                // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                    print("====> inactive")
                }
        }
        .onEnded { value in
            guard case .second(true, let drag?) = value else { return }
            self.viewState.width += drag.translation.width
            self.viewState.height += drag.translation.height
            print("====> onEnded")
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
            .overlay(dragState.isDragging && self.colorObject.isDraggable ? Circle().stroke(Color.white, lineWidth: 2) : nil)
            .offset(
                x: self.colorObject.isDraggable ? viewState.width + dragState.translation.width : 0,
                y: self.colorObject.isDraggable ? viewState.height + dragState.translation.height : 0
            )
//            .animation(nil)
//            .shadow(radius: dragState.isActive && self.colorObject.isDraggable ? 8 : 0)
            .animation(.linear(duration: minDuration))
            .gesture(self.colorObject.isDraggable && self.colorObject.flag ? longPressDrag : nil)
    }
    
}

#if DEBUG
struct ColorSlider2_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider2(colorObject: ColorObject(), width: 300, height: 40)
    }
}
#endif
