//
//  CustomView.swift
//  Example
//
//  Created by Daniel on 2019/9/5.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

class CustomView: UIView {

    weak var parent: UIViewController!
    
    deinit {
        print("======dealloc======view:\(self)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 34)
        btn.backgroundColor = .red
        btn.setTitle("close", for: .normal)
        btn.addTarget(self, action: #selector(closeBtnAction(_:)), for: .touchUpInside)
        self.addSubview(btn)
        btn.center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeBtnAction(_ sender: UIButton) {
        parent.dq.dismiss {
            print("dismiss complete")
        }
    }
    
}
