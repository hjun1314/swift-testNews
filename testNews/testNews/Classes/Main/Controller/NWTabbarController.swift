//
//  NWTabbarController.swift
//  testNews
//
//  Created by hjun on 2020/8/5.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit

class NWTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = RGBColors(r: 245, g: 90, b: 93)
        
        
      addChildViewController()
    }
    
    func addChildViewController() {
         setChilidVc(childController: NWHomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectImageName: "home_tabbar_press_32x32_")
        setChilidVc(childController: NWVideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectImageName: "video_tabbar_press_32x32_")
        setChilidVc(childController: NWHuoShanViewController(), title: "小视频", imageName: "huoshan_tabbar_32x32_", selectImageName: "huoshan_tabbar_press_32x32_")
        setChilidVc(childController: NWMineViewController(), title: "我的", imageName: "mine_tabbar_32x32_", selectImageName: "mine_tabbar_press_32x32_")
   
        setValue(NWMyTabbar(), forKey: "tabBar")
        
    }
    //初始化子控制器
    func setChilidVc(childController:UIViewController,title:String,imageName:String,selectImageName:String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectImageName)
                let nav = NWNavViewController(rootViewController: childController)
        addChild(nav)
        
    }
    

}
