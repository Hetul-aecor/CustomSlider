//
//  CustomSlider.swift
//  CommunageApp
//
//  Created by Hetul Soni on 28/03/22.
//

import SwiftUI

public struct CustomSlider<Component: View>: View {

    @Binding var value: Double
    public var range: (Double, Double)
    public var knobWidth: CGFloat?
    public let viewBuilder: (CustomSliderComponents) -> Component

    public init(value: Binding<Double>, range: (Double, Double), knobWidth: CGFloat? = nil,
         _ viewBuilder: @escaping (CustomSliderComponents) -> Component
    ) {
        _value = value
        self.range = range
        self.viewBuilder = viewBuilder
        self.knobWidth = knobWidth
    }

    public var body: some View {
        return GeometryReader { geometry in
            view(geometry: geometry)
        }
    }
}

//MARK:- View methods
extension CustomSlider {
    private func view(geometry: GeometryProxy) -> some View {
      let frame = geometry.frame(in: .global)
      let drag = DragGesture(minimumDistance: 0).onChanged({ drag in
        self.onDragChange(drag, frame) }
      )
      let offsetX = self.getOffsetX(frame: frame)

      let knobSize = CGSize(width: knobWidth ?? frame.height, height: frame.height)
      let barLeftSize = CGSize(width: CGFloat(offsetX + knobSize.width * 0.5), height:  frame.height)
      let barRightSize = CGSize(width: frame.width - barLeftSize.width, height: frame.height)

      let modifiers = CustomSliderComponents(
          leftBar: CustomSliderModifier(name: .leftBar, size: barLeftSize, offset: 0),
          rightBar: CustomSliderModifier(name: .rightBar, size: barRightSize, offset: barLeftSize.width),
          knob: CustomSliderModifier(name: .knob, size: knobSize, offset: offsetX))

      return ZStack {
          viewBuilder(modifiers)
          .gesture(drag)
      }
    }
}

//MARK:- Other methods
extension CustomSlider {
    private func onDragChange(_ drag: DragGesture.Value,_ frame: CGRect) {
        let width = (knob: Double(knobWidth ?? frame.size.height), view: Double(frame.size.width))
        let xrange = (min: 0.0, max: Double(width.view - width.knob))
        // knob center x
        var value = Double(drag.startLocation.x + drag.translation.width)
        // offset from center to leading edge of knob
        value -= width.knob * 0.5
        // limit to leading edge
        value = value > xrange.max ? xrange.max : value
        // limit to trailing edge
        value = value < xrange.min ? xrange.min : value
        value = value.convert(fromRange: (xrange.min, xrange.max), toRange: range)
        self.value = value
    }
    
    private func getOffsetX(frame: CGRect) -> CGFloat {
        let width = (knob: knobWidth ?? frame.size.height, view: frame.size.width)
        let xrange = (0.0, Double(width.view - width.knob))
        let result = self.value.convert(fromRange: range, toRange: xrange)
        return CGFloat(result)
    }
}
