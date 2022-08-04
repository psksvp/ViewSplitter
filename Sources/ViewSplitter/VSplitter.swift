//
//  VSplitter.swift
//
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

@available(macOS 11.0, *)
public struct VSplitter<TopContent: View, BottomContent: View>: View
{
  @ObservedObject public var config: SplitterConfig

  public var topView: TopContent
  public var bottomView: BottomContent

  public init(config: SplitterConfig,
              @ViewBuilder topView: () -> TopContent,
              @ViewBuilder bottomView: () -> BottomContent)
  {
    self.config = config
    self.topView = topView()
    self.bottomView = bottomView()
  }

  public var body: some View
  {
    GeometryReader
    {
      geometry in
      
      ZStack
      {
        HStack
        {
          Group
          {
            self.topView.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
          }
          Group
          {
            self.bottomView.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                           .frame(height: geometry.size.height * self.config.middle - self.config.current)
          }
        }
        HSplitterController(viewModel: self.config, geometry: geometry)
        {
          Group
          {
            ZStack
            {
              Image(systemName: "arrow.up.arrow.down.circle.fill").frame(width: 32, height: 32)
             }
          }
           .frame(minWidth: 0, maxWidth: .infinity)
        }
      } // ZStack
    } // GeometryReader
  }
}
