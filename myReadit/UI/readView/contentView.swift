//
//  ContentView.swift
//  myReadit
//
//  Created by 江南 on 2017/12/4.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit
import CoreText


class ContentView: UITextView {
    
    var readDelegate:readViewDelegate!
    var menuController:UIMenuController!
   
    // storyboard或xib创建控件的时候有效
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    var item=[UIMenuItem.init(title: "keyword", action: #selector(self.Keyword))]
    item.append(UIMenuItem.init(title: "highlight", action: #selector(self.Highlight)))
    item.append(UIMenuItem.init(title: "cancel", action: #selector(self.Cancel)))
        self.becomeFirstResponder()
        
        let menuController = UIMenuController.shared
    
        
        menuController.menuItems?.removeAll()
        menuController.menuItems=item
        menuController.setTargetRect(self.bounds, in: self)
    
    // 5. 显示菜单
   
        menuController.setMenuVisible(true, animated: true)
        menuController.update();
    
    
    }
    
    @objc func Keyword()
    {
        let key=self.text.substring(self.selectedRange)
        if (!key.isEmpty){
            readDelegate.addKeyword(key)}
        else {return
        }
    }
    @objc func Highlight(menu :UIMenuController )
    {
        let attributedString = self.attributedText.mutableCopy() as!  NSMutableAttributedString
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.brown , range: self.selectedRange)
        readDelegate.addMark(self.selectedRange)
        self.attributedText=attributedString
      
    }
    @objc func Cancel()
    {
        self.selectedRange=NSMakeRange(0,0)
       return
    }
    override var canBecomeFirstResponder: Bool{
        get{
            return true
        }
    }
   
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        // 判断 action 中包含的各个事件的方法名称, 对比上了才能显示
        if (action == Selector.init("copy:") || action == #selector(self.Keyword) || action == #selector(self.Highlight) || action == #selector(self.Cancel))
        {
            return true
        }
        return false
    }
    
}


