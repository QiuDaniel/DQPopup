//
//  UIViewController+DQPopup.swift
//  RabbitOptimization
//
//  Created by Daniel on 2019/9/3.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

private var popupViewKey: Void?
private var overlayViewKey: Void?
private var animationTypeKey: Void?
private var completionCallbackKey: Void?
private var backgroundTapKey: Void?

extension DQPopup where Base: UIViewController {
    fileprivate weak var _dqPopupView: UIView? {
        get {
            return objc_getAssociatedObject(base, &popupViewKey) as? UIView
        }
        
        set {
            objc_setAssociatedObject(base, &popupViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate weak var _dqOverlayView: UIView? {
        get {
            return objc_getAssociatedObject(base, &overlayViewKey) as? UIView
        }
        
        set {
            objc_setAssociatedObject(base, &overlayViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate weak var _popupAnimation: DQPopupAnimationType? {
        get {
            return objc_getAssociatedObject(base, &animationTypeKey) as? DQPopupAnimationType
        }
        
        set {
            objc_setAssociatedObject(base, &animationTypeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate var _completionCallback: CompletionHandler? {
        get {
            return objc_getAssociatedObject(base, &completionCallbackKey) as? CompletionHandler
        }
        
        set {
            objc_setAssociatedObject(base, &completionCallbackKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    fileprivate var _isEnableBackgroundTap: Bool {
        get {
            guard let enableNum = objc_getAssociatedObject(base, &backgroundTapKey) as? NSNumber else { return true }
            return enableNum.boolValue
        }
        
        set {
            return objc_setAssociatedObject(base, &backgroundTapKey, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension DQPopup where Base: UIViewController {
    
    public var dqPopupView: UIView? {
        return _dqPopupView
    }
    
    public var dqOverlayView: UIView? {
        return _dqOverlayView
    }
    
    public var isEnableBackgroundTap: Bool {
        get {
            return _isEnableBackgroundTap
        }
        
        set {
            _isEnableBackgroundTap = newValue
        }
    }
    
    //MARK: - Public
    
    public func present(_ popupView: UIView, animation: DQPopupAnimationType)  {
        _present(popupView, animation: animation)
    }
    
    public func dismiss(_ animation: DQPopupAnimationType? = nil, completion: CompletionHandler? = nil) {
        guard let animation = animation else {
            _dismiss(_popupAnimation, completion: completion)
            return
        }
        _dismiss(animation, completion: completion)
        
    }
    
    //MARK: - Private
    
    private func _topView() -> UIView {
        var recentControler:UIViewController = base
        while (recentControler.parent != nil) {
            recentControler = recentControler.parent!
        }
        return recentControler.view
    }
    
    private func _present(_ popupView: UIView, animation: DQPopupAnimationType)  {
        if let overlayView = _dqOverlayView, overlayView.subviews.contains(popupView) {
            return
        }
        
        _dqPopupView = nil
        _dqPopupView = popupView
        _popupAnimation = nil
        _popupAnimation = animation
        
        let sourceView = _topView()
        _dqPopupView!.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        if _dqOverlayView == nil {
            let view = UIView(frame: sourceView.bounds)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.backgroundColor = .clear
            
            let backgroundView = UIView(frame: sourceView.bounds)
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            view.addSubview(backgroundView)
            
            if let gesture = backgroundView.gestureRecognizers, gesture.count > 0 {
                gesture.forEach { backgroundView.removeGestureRecognizer($0) }
            }
            
            let tap = UITapGestureRecognizer(target: base, action: #selector(base.backTapAction))
            backgroundView.addGestureRecognizer(tap)
            
            _dqOverlayView = view
        }
        _dqOverlayView!.addSubview(_dqPopupView!)
        sourceView.addSubview(_dqOverlayView!)
        _dqOverlayView?.alpha = 1.0
        _dqPopupView!.center = _dqOverlayView!.center
        
        animation.show(_dqPopupView!, overlayView: _dqOverlayView!)
    }
    
    private func _dismiss(_ animation: DQPopupAnimationType? = nil, completion: CompletionHandler? = nil) {
        _completionCallback = completion
        guard let animation = animation else {
            execute()
            return
        }
        animation.dismss(_dqPopupView!, overlayView: _dqOverlayView!) {
            self.execute()
        }
      
    }
    
    private func execute() {
        _dqPopupView?.removeFromSuperview()
        _dqOverlayView?.removeFromSuperview()
        _dqPopupView = nil
        _popupAnimation = nil
        
        guard let completionCallback = _completionCallback else { return }
        completionCallback()
        _completionCallback = nil
    }
    
}

extension UIViewController {
    @objc fileprivate func backTapAction() {
        if dq.isEnableBackgroundTap {
            dq.dismiss()
        }
    }
}
