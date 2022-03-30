//
//  CustomSliderModifier.swift
//  CommunageApp
//
//  Created by Hetul Soni on 28/03/22.
//

import SwiftUI

public struct CustomSliderComponents {
    let leftBar: CustomSliderModifier
    let rightBar: CustomSliderModifier
    let knob: CustomSliderModifier
}

struct CustomSliderModifier: ViewModifier {
    enum SliderComponentName {
        case leftBar
        case rightBar
        case knob
    }
    let name: SliderComponentName
    let size: CGSize
    let offset: CGFloat

    func body(content: Content) -> some View {
        content
        .frame(width: size.width)
        .position(x: size.width*0.5, y: size.height*0.5)
        .offset(x: offset)
    }
}
