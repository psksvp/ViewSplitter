//
//  File.swift
//  
//
//  Created by psksvp on 4/7/2022.
//

import Foundation
import SwiftUI

public class SplitterConfig: ObservableObject
{
  @Published public var current: CGFloat = 0
  @Published public var previous: CGFloat = 0
  @Published public var isMax = false
  @Published public var isMin = false
  public var middle: CGFloat
  public var range: ClosedRange<CGFloat>
  public init(middle: CGFloat = 0.5, range: ClosedRange<CGFloat> = 0.2...0.8)
  {
    precondition(range.lowerBound >= 0, "Range lower bound must be positive")
    precondition(range.upperBound >= 0, "Range upper bound must be positive")
    precondition(range.lowerBound < middle && range.upperBound > middle, "Middle value must be inrange:\(range)")
    self.middle = middle
    self.range = range
  }
}
