//
//  VSplitter.swift
//
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
@available(macOS 12.0, *)
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
        HSplitterController(viewConfig: self.config, geometry: geometry)
        {
          Group
          {
            ZStack
            {
              
              Rectangle()
                .fill(.bar)
                .frame(width: geometry.size.width, height: 3)
              Image(systemName: "arrow.up.arrow.down.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
            }
          }
           .frame(minWidth: 0, maxWidth: .infinity)
        }
      } // ZStack
    } // GeometryReader
  }
}
