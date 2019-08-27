
# SwiftUI ColorSlider


![im01](image01.png)  ![im02](image02.png) 


**ColorSlider** is a SwiftUI view (xCode 11 beta 6) that displays a color slider.
It is used to dynamically select a color from a range of colors or grayscale.

The main elements are **ColorSlider.swift** and **ColorObject.swift**, see the demo in **ContenView.swift** for how to use it in your code.

The key to using this *ColorSlider* in your code is to create a **ColorObject** such as:

    @ObservedObject var colorObject = ColorObject()

and pass it to the *ColorSlider* as shown in *ContenView.swift*,

    ColorSlider(colorObject: colorObject, width: 300, height: 40)
    
As the slider knob is changed, the current color selected can be obtain from the **ColorObject** using:
    
    colorObject.color
    
The following can be set to customise the **ColorObject**:

- nColors, the number of colors to display in the slider, default 100.
- saturation, the desired saturation value, default 1.
- brightness, the desired brightness value, default 1.
- isDraggable, to allow the slider to be dragged around the screen, default true

**ColorSlider** will display a slider gradient of colors, from white to black.

For convenience, to display a gray scale slider, initialise the  **ColorObject** as:

    @ObservedObject var colorObject = ColorObject(grayScale: true)
    
For convenience, to display a static slider, initialise the  **ColorObject** as:

    @ObservedObject var colorObject = ColorObject(isDraggable: false)    
    
![im1](image1.png) ![im2](image2.png) ![im3](image3.png)

