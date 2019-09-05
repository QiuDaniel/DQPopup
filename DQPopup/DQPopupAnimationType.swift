//
//  DQPopAnimationType.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

public typealias CompletionHandler = (() -> Void)

public protocol DQPopupAnimationType: NSObjectProtocol {
    func show(_ popupView: UIView, overlayView: UIView)
    func dismss(_ popupView: UIView, overlayView: UIView, completion: @escaping CompletionHandler)
}
