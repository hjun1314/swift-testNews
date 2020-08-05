//
//  NWMyTabbar.swift
//  testNews
//
//  Created by hjun on 2020/8/5.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit

class NWMyTabbar: UITabBar {

    override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(publishButton)
       }
    
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type:.custom)
        publishButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        publishButton.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        publishButton.addTarget(self, action: #selector(publishButtonAction), for: .touchUpInside)
        publishButton.sizeToFit()
        return publishButton
    }()
    
    @objc func publishButtonAction() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        let height = frame.height
        
        publishButton.center = CGPoint(x:width * 0.5,y:height * 0.5 - 20)
        
        let buttonW:CGFloat = width * 0.2
        let buttonH:CGFloat = height
        let buttonY:CGFloat = 0
        
        var index = 0
        
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) {
                continue
            }
            
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
                       
                       button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
                       
                       index += 1
        }
        
        
        
        
        
    }

}
