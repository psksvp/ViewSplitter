//
//  HSplitterController.swift
//  
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

struct HSplitterController<Content: View>: View
{
  @ObservedObject var viewConfig: SplitterConfig

  var geometry: GeometryProxy
  let content: Content

  public init(viewConfig: SplitterConfig,
              geometry: GeometryProxy,
              @ViewBuilder content: () -> Content)
  {
    self.viewConfig = viewConfig
    self.content = content()
    self.geometry = geometry
  }

  var body: some View
  {
    HStack { content }
    .offset(x: geometry.size.width * (0.5 - viewConfig.middle) + viewConfig.current)
    .gesture(DragGesture().onChanged(onDragChanged)
                          .onEnded(onDragEnded))
  }

  fileprivate var maxLimit: CGFloat
  {
    geometry.size.width * (viewConfig.middle - viewConfig.range.upperBound)
  }

  fileprivate var minLimit: CGFloat
  {
    geometry.size.width * (viewConfig.middle - viewConfig.range.lowerBound)
  }

  fileprivate func onDragChanged(_ gesture: DragGesture.Value)
  {
    let width = viewConfig.previous + gesture.translation.width

    viewConfig.current = max(maxLimit, min(minLimit, width))
    viewConfig.isMax = viewConfig.current == maxLimit
    viewConfig.isMin = viewConfig.current == minLimit
  }

  fileprivate func onDragEnded(_ gesture: DragGesture.Value)
  {
    viewConfig.previous = viewConfig.current
  }
}
