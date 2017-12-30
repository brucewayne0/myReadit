//
//  chapterNodeModel.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//
import UIKit
import Foundation
class ChapterNode : NSObject, NSCoding
{
    
    var Num:Int = 0//章节号
    var Name:String//章节名，关键词
    var Destination:NSRange//指向定位
    var Progress:Float//文中进度
    
    init?(_ Num:Int,_ Name:String,_ Destination: NSRange,_ Progress:Float)
    {
        self.Num=Num
        self.Name=Name
        self.Destination=Destination
        self.Progress=Progress
        
    }
    struct PropertyKey {
        static let  Num="Num"
        static let Name="Name"
        static let Destination="Destination"
        static let Progress="Progress"
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Num, forKey: PropertyKey.Num)
        aCoder.encode(Name, forKey: PropertyKey.Name)
        aCoder.encode(Destination, forKey: PropertyKey.Destination)
        aCoder.encode(Progress, forKey: PropertyKey.Progress)
    
  
}
    required convenience init?(coder aDecoder: NSCoder) {
        let Num = aDecoder.decodeInteger(forKey: PropertyKey.Num)
        let Name = aDecoder.decodeObject(forKey: PropertyKey.Name)as! String
        let Destination=aDecoder.decodeObject(forKey: PropertyKey.Destination)as! NSRange
        let Progress=aDecoder.decodeFloat(forKey: PropertyKey.Progress)
        self.init(Num,Name,Destination,Progress)
    }
}
class MarkNode : NSObject, NSCoding{
    var Content:String
    var Range:NSRange
    init?(_ content:String,_ range: NSRange)
    {
        Content=content
        Range=range
    }
    
    struct PropertyKey {
        static let  Content="Content"
        static let Range="Range"
        
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Content, forKey: PropertyKey.Content)
        aCoder.encode(Range, forKey: PropertyKey.Range)
        
        
    }
    required convenience init?(coder aDecoder: NSCoder) {
       
        let Content = aDecoder.decodeObject(forKey: PropertyKey.Content)as! String
        let Range=aDecoder.decodeObject(forKey: PropertyKey.Range)as! NSRange
       
        self.init(Content,Range)
    }
    
}
class KeyNode : NSObject, NSCoding{
    var Key:String
    var Description:String
    
    init?(_ key: String,_ des:String)
    {
        Key=key
        Description=des
    }
    struct PropertyKey {
        static let  Key="Key"
        static let Description="Description"
        
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Key, forKey: PropertyKey.Key)
        aCoder.encode(Description, forKey: PropertyKey.Description)
        
        
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        let Key = aDecoder.decodeObject(forKey: PropertyKey.Key)as! String
        
         let Description = aDecoder.decodeObject(forKey: PropertyKey.Description)as! String
        self.init(Key,Description)
    }
    
    
}

