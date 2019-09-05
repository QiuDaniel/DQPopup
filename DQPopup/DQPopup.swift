//
//  DQPopup.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

public final class DQPopup<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol DQPopupCompatible {}

extension DQPopupCompatible {
    
    public static var dq: DQPopup<Self>.Type {
        get {
            return DQPopup<Self>.self
        }
        set {}
    }
    
    public var dq: DQPopup<Self> {
        get {
            return DQPopup(self)
        }
        set {}
    }
}

extension UIViewController: DQPopupCompatible { }
