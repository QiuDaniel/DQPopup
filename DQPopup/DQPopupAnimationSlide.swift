//
//  DQPopupAnimationSlide.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

public enum DQPopupAnimationSlideStyle {
    case bottomtop
    case bottombottom
    case toptop
    case topbottom
    case leftleft
    case leftright
    case rightleft
    case rightright
}

public class DQPopupAnimationSlide: NSObject, DQPopupAnimationType {
    
    private let style: DQPopupAnimationSlideStyle
    
    public init(style: DQPopupAnimationSlideStyle = .bottombottom) {
        self.style = style
    }
    
    public func show(_ popupView: UIView, overlayView: UIView) {
        let sourceSize = overlayView.bounds.size
        let popupSize = popupView.bounds.size
        var popupStartRect: CGRect!
        
        switch style {
        case .bottomtop, .bottombottom:
            popupStartRect = CGRect(x: (sourceSize.width - popupSize.width) / 2, y: sourceSize.height, width: popupSize.width, height: popupSize.height)
        case .leftleft, .leftright:
            popupStartRect = CGRect(x: -sourceSize.width, y: (sourceSize.height - popupSize.height) / 2, width: popupSize.width, height: popupSize.height)
        case .toptop, .topbottom:
            popupStartRect = CGRect(x: (sourceSize.width - popupSize.width) / 2, y: -popupSize.height, width: popupSize.width, height: popupSize.height)
        default:
            popupStartRect = CGRect(x: sourceSize.width, y: (sourceSize.height - popupSize.height) / 2, width: popupSize.width, height: popupSize.height)
        }
        
        let popupEndRect = CGRect(x: (sourceSize.width - popupSize.width) / 2, y: (sourceSize.height - popupSize.height) / 2, width: popupSize.width, height: popupSize.height)
        
        popupView.frame = popupStartRect
        popupView.alpha = 1.0
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
            popupView.frame = popupEndRect
        }, completion: nil)
    }
    
    public func dismss(_ popupView: UIView, overlayView: UIView, completion: @escaping CompletionHandler) {
        let sourceSize = overlayView.bounds.size
        let popupSize = popupView.bounds.size
        var popupEndRect: CGRect!
        switch style {
        case .bottomtop, .toptop:
            popupEndRect = CGRect(x: (sourceSize.width - popupSize.width) / 2, y: -popupSize.height, width: popupView.frame.width, height: popupSize.height)
        case .bottombottom, .topbottom:
            popupEndRect = CGRect(x: (sourceSize.width - popupSize.width) / 2, y: sourceSize.height, width: popupSize.width, height: popupSize.height)
        case .leftright, .rightright:
            popupEndRect = CGRect(x: sourceSize.width, y: popupView.frame.origin.y, width: popupSize.width, height: popupSize.height)
        default:
            popupEndRect = CGRect(x: -popupSize.width, y: popupView.frame.origin.y, width: popupSize.width, height: popupSize.height)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            popupView.frame = popupEndRect
            overlayView.alpha = 0.0
        }) { (finished) in
            if finished {
                completion()
            }
        }
    }
}
