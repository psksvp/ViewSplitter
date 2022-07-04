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
  @ObservedObject var viewModel: SplitterConfig

  var geometry: GeometryProxy
  let content: Content

  public init(viewModel: SplitterConfig,
              geometry: GeometryProxy,
              @ViewBuilder content: () -> Content)
  {
    self.viewModel = viewModel
    self.content = content()
    self.geometry = geometry
  }

  var body: some View
  {
    HStack { content }
    .offset(x: geometry.size.width * (0.5 - viewModel.middle) + viewModel.current)
    .gesture(DragGesture().onChanged(onDragChanged)
                          .onEnded(onDragEnded))
  }

  fileprivate var maxLimit: CGFloat
  {
    geometry.size.width * (viewModel.middle - viewModel.range.upperBound)
  }

  fileprivate var minLimit: CGFloat
  {
    geometry.size.width * (viewModel.middle - viewModel.range.lowerBound)
  }

  fileprivate func onDragChanged(_ gesture: DragGesture.Value)
  {
    let width = viewModel.previous + gesture.translation.width

    viewModel.current = max(maxLimit, min(minLimit, width))
    viewModel.isMax = viewModel.current == maxLimit
    viewModel.isMin = viewModel.current == minLimit
  }

  fileprivate func onDragEnded(_ gesture: DragGesture.Value)
  {
    viewModel.previous = viewModel.current
  }
}
