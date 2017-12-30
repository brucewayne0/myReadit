//
//  Extension.swift
//  myReadit
//
//  Created by 江南 on 2017/12/1.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
   
    var length:Int {
        get{return (self as NSString).length}
}
    
    func substring(_ range:NSRange) ->String {
        
        return NSString(string: self).substring(with: range)
    }
    
    // 获得文件名

     
    func stringByDeletingPathExtension() ->String {
        
        return NSString(string: self).deletingPathExtension
    }
}


