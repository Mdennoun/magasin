//
//  AppDelegate.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: MapViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }



}

