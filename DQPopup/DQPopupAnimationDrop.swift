//
//  DQPopupAnimationDrop.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

public class DQPopupAnimationDrop: NSObject, DQPopupAnimationType {
    
    public func show(_ popupView: UIView, overlayView: UIView) {
        popupView.center = CGPoint(x: overlayView.center.x, y: -popupView.bounds.size.height / 2)
        popupView.transform = CGAffineTransform(rotationAngle: CGFloat(-M_1_PI / 1.5))
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            popupView.transform = CGAffineTransform(rotationAngle: 0)
            popupView.center = overlayView.center
        }, completion: nil)
    }
    
    public func dismss(_ popupView: UIView, overlayView: UIView, completion: @escaping CompletionHandler) {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut, animations: {
            popupView.center = CGPoint(x: overlayView.center.x, y: overlayView.bounds.size.height + popupView.bounds.size.height)
            popupView.transform = CGAffineTransform(rotationAngle: CGFloat(M_1_PI / 1.5))
            overlayView.alpha = 0.0
        }) { finished in
            if finished {
                completion()
            }
        }
    }
}
