//
//  AppDelegate.swift
//  testNews
//
//  Created by hjun on 2020/8/5.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
              self.window = UIWindow(frame: UIScreen.main.bounds)
              self.window?.backgroundColor = UIColor.white
              
              self.window?.rootViewController = NWTabbarController()
              self.window?.makeKeyAndVisible()
        return true
    }

  


}

