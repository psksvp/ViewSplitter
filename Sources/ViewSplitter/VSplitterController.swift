//
//  VSplitterController.swift
//
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

struct VSplitterController<Content: View>: View
{
  @ObservedObject var config: SplitterConfig

  var geometry: GeometryProxy
  let content: Content

  public init(viewModel: SplitterConfig,
              geometry: GeometryProxy,
              @ViewBuilder content: () -> Content)
  {
    self.config = viewModel
    self.content = content()
    self.geometry = geometry
  }

  var body: some View
  {
    HStack { content }
    .offset(y: geometry.size.height * (0.5 - config.middle) + config.current)
    .gesture(DragGesture().onChanged(onDragChanged)
                          .onEnded(onDragEnded))
  }

  fileprivate var maxLimit: CGFloat
  {
    geometry.size.height * (config.middle - config.range.upperBound)
  }

  fileprivate var minLimit: CGFloat
  {
    geometry.size.height * (config.middle - config.range.lowerBound)
  }

  fileprivate func onDragChanged(_ gesture: DragGesture.Value)
  {
    let height = config.previous + gesture.translation.height

    config.current = max(maxLimit, min(minLimit, height))
    config.isMax = config.current == maxLimit
    config.isMin = config.current == minLimit
  }

  fileprivate func onDragEnded(_ gesture: DragGesture.Value)
  {
    config.previous = config.current
  }
}

