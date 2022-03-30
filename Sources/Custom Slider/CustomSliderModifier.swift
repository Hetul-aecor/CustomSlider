//
//  CustomSliderModifier.swift
//  CommunageApp
//
//  Created by Hetul Soni on 28/03/22.
//

import SwiftUI

public struct CustomSliderComponents {
    public let leftBar: CustomSliderModifier
    public let rightBar: CustomSliderModifier
    public let knob: CustomSliderModifier
}

public struct CustomSliderModifier: ViewModifier {
    public enum SliderComponentName {
        case leftBar
        case rightBar
        case knob
    }
    public let name: SliderComponentName
    public let size: CGSize
    public let offset: CGFloat

    public func body(content: Content) -> some View {
        content
        .frame(width: size.width)
        .position(x: size.width*0.5, y: size.height*0.5)
        .offset(x: offset)
    }
}
