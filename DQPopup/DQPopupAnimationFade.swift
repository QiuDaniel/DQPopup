//
//  DQPopupAnimationFade.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

public class DQPopupAnimationFade:NSObject, DQPopupAnimationType {
    
    public func show(_ popupView: UIView, overlayView: UIView) {
        popupView.center = overlayView.center
        popupView.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            popupView.alpha = 1.0
        }
    }
    
    public func dismss(_ popupView: UIView, overlayView: UIView, completion: @escaping CompletionHandler) {
        UIView.animate(withDuration: 0.25, animations: {
            overlayView.alpha = 0.0
            popupView.alpha = 0.0
        }) { finished in
            if finished {
                completion()
            }
        }
    }
}
