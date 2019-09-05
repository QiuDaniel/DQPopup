//
//  ViewController.swift
//  Example
//
//  Created by Daniel on 2019/9/5.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    //MARK: - ResponseEvent
    
    @IBAction func fadeBtnAction(_ sender: UIButton) {
        dq.isEnableBackgroundTap = false
        let view = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view.parent = self
        dq.present(view, animation: DQPopupAnimationFade())
    }
    
    @IBAction func springBtnAction(_ sender: UIButton) {
        dq.isEnableBackgroundTap = true
        let view = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view.parent = self
        dq.present(view, animation: DQPopupAnimationSpring())
    }
    
    @IBAction func dropBtnAction(_ sender: UIButton) {
        let view = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view.parent = self
        dq.present(view, animation: DQPopupAnimationDrop())
    }
    
    @IBAction func slideBtnAction(_ sender: UIButton) {
        let view = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view.parent = self
        dq.present(view, animation: DQPopupAnimationSlide())
    }
    
}

