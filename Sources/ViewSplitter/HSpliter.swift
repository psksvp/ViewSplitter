
//
//  HSplitter.swift
//  
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct HSplitter<LeftContent: View, RightContent: View, DividerView: View>: View
{
  @ObservedObject public var config: SplitterConfig

  public var leftView: LeftContent
  public var rightView: RightContent
  public var dividerView: DividerView

  public init(config: SplitterConfig,
              @ViewBuilder leftView: () -> LeftContent,
              @ViewBuilder rightView: () -> RightContent,
              @ViewBuilder dividerView: () -> DividerView)
  {
    self.config = config
    self.leftView = leftView()
    self.rightView = rightView()
    self.dividerView = dividerView()
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
            self.leftView.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
          }
          Group
          {
            self.rightView.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                          .frame(width: geometry.size.width * self.config.middle - self.config.current)
          }
        }
        HSplitterController(viewConfig: self.config, geometry: geometry)
        {
          Group
          {
            self.dividerView
          }
           .frame(minWidth: 0, maxWidth: .infinity)
        }
      } // ZStack
    } // GeometryReader
  }
}
