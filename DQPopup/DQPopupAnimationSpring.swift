//
//  DQPopupAnimationSpring.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

public class DQPopupAnimationSpring:NSObject, DQPopupAnimationType, CAAnimationDelegate {
    
    private var completion: CompletionHandler?
    
    public func show(_ popupView: UIView, overlayView: UIView) {
        popupView.alpha = 1.0
        
        let popAnimation = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = 0.4
        popAnimation.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.01, 0.01, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue(caTransform3D: CATransform3DIdentity)]
        popAnimation.keyTimes = [(0.2), (0.5), (0.75), (1.0)]
        popAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)]
        popupView.layer.add(popAnimation, forKey: nil)
    }
    
    public func dismss(_ popupView: UIView, overlayView: UIView, completion: @escaping () -> Void) {
        
        self.completion = completion
        
        let hideAnimation = CAKeyframeAnimation(keyPath: "transform")
        hideAnimation.duration = 0.4
        hideAnimation.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(0.0, 0.0, 0.0)),
            NSValue(caTransform3D: CATransform3DIdentity)]
        hideAnimation.keyTimes = [(0.2), (0.5), (0.75)]
        hideAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)]
        hideAnimation.delegate = self
        popupView.layer.add(hideAnimation, forKey: nil)
        
        UIView.animate(withDuration: 0.4) {
            overlayView.alpha = 0
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let completion = self.completion else {
            return
        }
        completion()
        self.completion = nil
    }
}

