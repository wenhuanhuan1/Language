//
//  MineViewController.swift
//  Localitylanguage
//
//  Created by WHH on 2022/1/13.
//

import UIKit

class MineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(type: .custom)
        btn.setTitle(LanguageManager.shared.getStringBykey("loginKey"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.backgroundColor = .red
        
        let settingBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(changeLanguage))
        navigationItem.rightBarButtonItem = settingBtn

        
    }
    
   @objc func changeLanguage() {
        
       LanguageManager.shared.setCurrentLanguage(language: LanguageTye.ja)
    }
    
}
