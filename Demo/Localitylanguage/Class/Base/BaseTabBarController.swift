//
//  BaseTabBarController.swift
//  Localitylanguage
//
//  Created by WHH on 2022/1/13.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainVC = MainViewController()
        setChildVc(mainVC, LanguageManager.shared.getStringBykey("mainTabBarKey"), "", "")
        let mineVC = MineViewController()
        setChildVc(mineVC, LanguageManager.shared.getStringBykey("mineTabBarKey"), "", "")
    }

    func setChildVc(_ vc: UIViewController, _ title: String, _ normalImageStr: String, _ selectImageStr: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: normalImageStr)
        vc.tabBarItem.selectedImage = UIImage(named: selectImageStr)
        let navigationController = BaseNavigationController(rootViewController: vc)
        addChild(navigationController)
    }
}
