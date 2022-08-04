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
              Rectangle()
                .fill(.bar)
                .frame(width: 3, height: geometry.size.height)
              Image(systemName: "arrow.left.arrow.right.circle.fill")
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
