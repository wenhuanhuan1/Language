//
//  AppDelegate.swift
//  Localitylanguage
//
//  Created by WHH on 2022/1/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LanguageManager.shared.initLanguage()
        LoadRootUI()
        return true
    }

    
    // MARK:LoadUI
    func LoadRootUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = BaseTabBarController()
        window?.makeKeyAndVisible()
    }
}
