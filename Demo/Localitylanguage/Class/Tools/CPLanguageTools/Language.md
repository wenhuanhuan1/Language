# 使用说明

1、初始化默认系统语言   LanguageManager.shared.initLanguage()

2、更改语言 中文使用  直接在LanguageManager -> LanguageTye增加需要修改的语言类型
 调用  LanguageManager.shared.setCurrentLanguage(language:LanguageTye.en )

3、获取对应的标题内容使用  LanguageManager.shared.getStringBykey("key")

