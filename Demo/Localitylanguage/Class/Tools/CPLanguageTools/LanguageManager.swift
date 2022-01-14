//
//  LanguageManager.swift
//  Localitylanguage
//
//  Created by WHH on 2022/1/13.
//  本地语言切换管理类
import Foundation
import UIKit

private let languageSaveKey = "languageSaveKey"

enum LanguageTye: String {
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case en = "en"
    case ja = "ja"
}

struct LanauageManagerNotificationName {
    /// 切换语言完成的回调
    static let notificationName = Notification.Name(rawValue: "LanauageManagerNotificationNameKey")
}

class LanguageManager: NSObject {
    var bundle: Bundle?
    var currentLanguage: LanguageTye?
}

extension LanguageManager {
    static let shared = LanguageManager()

    func initLanguage() {
        if UserDefaults.whhObjectFor(languageSaveKey) != nil {
            /// 说明用户已经切换过语言
            let tempLanguage = UserDefaults.whhObjectFor(languageSaveKey)
            currentLanguage = LanguageTye(rawValue: tempLanguage as! String)
            #if DEBUG
                print("当前语言------\(tempLanguage ?? "")")
            #endif
        } else {
            currentLanguage = getSystemLanguage()
        }

        if let currentLanguage = currentLanguage {
            let path = Bundle.main.path(forResource: languageFormat(language: currentLanguage).rawValue, ofType: "lproj")
            if let path = path {
                bundle = Bundle(path: path)
            }
        }
    }

    // MARK: 设置当前语言

    func setCurrentLanguage(language: LanguageTye) {
        currentLanguage = language
        if let currentLanguage = currentLanguage {
            let path = Bundle.main.path(forResource: languageFormat(language: currentLanguage).rawValue, ofType: "lproj")
            if let path = path {
                bundle = Bundle(path: path)
            }
            UserDefaults.whhSet(languageSaveKey, currentLanguage.rawValue)
            changeLanguageFinish()
            #if DEBUG
                print("更新了当前语言当------\(currentLanguage)")
            #endif
        }
    }

    // MARK: 设置完语言的操作

    private func changeLanguageFinish() {
        NotificationCenter.default.post(name: LanauageManagerNotificationName.notificationName, object: nil)
        let applicationDelegate = UIApplication.shared.delegate
        let tabBarController = BaseTabBarController()
        applicationDelegate?.window!!.rootViewController = tabBarController
        tabBarController.selectedIndex = tabBarController.children.count - 1
    }

    private func languageFormat(language: LanguageTye) -> LanguageTye {
        if language.rawValue.range(of: "zh-Hans") != nil {
            return LanguageTye(rawValue: "zh-Hans") ?? LanguageTye.zhHans
        } else if language.rawValue.range(of: "zh-Hant") != nil {
            return LanguageTye(rawValue: "zh-Hant") ?? LanguageTye.zhHans
        } else {
            if language.rawValue.range(of: "-") != nil {
                let arr = language.rawValue.components(separatedBy: "-")
                if arr.count > 1 {
                    #if DEBUG
                        print("当前的取得语言组合------\(arr.first!)")
                    #endif
                    return LanguageTye(rawValue: arr.first!) ?? LanguageTye.zhHans
                }
            }
        }

        return language
    }

    // MARK: 获取系统当前语言名字

    func getSystemLanguage() -> LanguageTye? {
        let appLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        #if DEBUG
            if let language = appLanguages {
                print("当前的系统语言环境------\(language)")
            }

        #endif
        return LanguageTye(rawValue: appLanguages?.first ?? "")
    }

    // MARK: 通过key获取对应的值

    func getStringBykey(_ key: String) -> String {
        if let value = LanguageManager.shared.bundle?.localizedString(forKey: key, value: "", table: nil) {
            return value
        } else {
            return ""
        }
    }
}

extension UserDefaults {
    static func whhSet(_ key: String, _ data: Any) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func whhObjectFor(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
