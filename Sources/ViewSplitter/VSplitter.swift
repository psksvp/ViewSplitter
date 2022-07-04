//
//  VSplitter.swift
//
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

public struct VSplitter<ControlView: View, TopContent: View, BottomContent: View>: View
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
              Circle().fill()
                      .frame(width: 24, height: 24)
             }
          }
           .foregroundColor(Color.green)
           .frame(minWidth: 0, maxWidth: .infinity)
        }
      } // ZStack
    } // GeometryReader
  }
}
