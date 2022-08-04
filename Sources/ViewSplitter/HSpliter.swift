//
//  HSplitter.swift
//  
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

@available(macOS 11.0, *)
public struct HSplitter<LeftContent: View, RightContent: View>: View
{
  @ObservedObject public var config: SplitterConfig

  public var leftView: LeftContent
  public var rightView: RightContent

  public init(config: SplitterConfig,
              @ViewBuilder leftView: () -> LeftContent,
              @ViewBuilder rightView: () -> RightContent)
  {
    self.config = config
    self.leftView = leftView()
    self.rightView = rightView()
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
        HSplitterController(viewModel: self.config, geometry: geometry)
        {
          Group
          {
            ZStack
            {
              Image(systemName: "arrow.left.arrow.right.circle.fill")
//              Circle().fill()
//                      .frame(width: 24, height: 24)
             }
          }
           .frame(minWidth: 0, maxWidth: .infinity)
        }
      } // ZStack
    } // GeometryReader
  }
}
