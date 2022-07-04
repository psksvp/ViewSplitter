//
//  HSplitter.swift
//  
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

public struct HSplitter<ControlView: View, LeftContent: View, RightContent: View>: View
{
  @ObservedObject public var config: SplitterConfig

  public var leftView: LeftContent
  public var rightView: RightContent

  public init(viewModel: SplitterConfig,
              @ViewBuilder leftView: () -> LeftContent,
              @ViewBuilder rightView: () -> RightContent)
  {
    self.config = viewModel
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
