//
//  BookModel.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import Foundation
import UIKit
import os.log
class Book: NSObject, NSCoding{
    
    
    
    
    var name:String
    var cover:UIImage?
    var currentLine:Int
    var chapterList=[ChapterNode]()
    var markList=[MarkNode]()
    var keywordList=[KeyNode]()
   
    var PreviousProgress:Float
    var Note=""
    var length:Float
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("books")
    
    init?(_ name:String,_ cover:UIImage?,currentLine:Int,PreviousProgress:Float,Note:String,length:Float,chapterList:[ChapterNode],markList:[MarkNode],keywordList:[KeyNode] )
    {
        
        self.name=name
        self.cover=cover
        self.currentLine=currentLine
        self.PreviousProgress=PreviousProgress
        self.Note=Note
        self.length=length
        self.chapterList=chapterList
        self.markList=markList
        self.keywordList=keywordList
        
    }
    //MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let cover = aDecoder.decodeObject(forKey: PropertyKey.cover) as? UIImage
        let currentLine = aDecoder.decodeInteger(forKey: PropertyKey.currentLine)
        let chapterList = aDecoder.decodeObject(forKey: PropertyKey.chapterList) as? [ChapterNode]
        let markList = aDecoder.decodeObject(forKey: PropertyKey.markList) as? [MarkNode]
        let keywordList = aDecoder.decodeObject(forKey: PropertyKey.keywordList) as? [KeyNode]

        let PreviousProgress = aDecoder.decodeFloat(forKey: PropertyKey.PreviousProgress)
        let Note=aDecoder.decodeObject(forKey: PropertyKey.Note) as! String
        let length = aDecoder.decodeFloat(forKey: PropertyKey.length)
        self.init(name,cover,currentLine:currentLine,PreviousProgress:PreviousProgress,Note:Note,length:length,chapterList:chapterList!,markList:markList!,keywordList: keywordList!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(cover, forKey: PropertyKey.cover)
        aCoder.encode(currentLine, forKey: PropertyKey.currentLine)
        aCoder.encode(chapterList, forKey: PropertyKey.chapterList)
        aCoder.encode(markList, forKey: PropertyKey.markList)
        aCoder.encode(keywordList, forKey: PropertyKey.keywordList)
        aCoder.encode(PreviousProgress, forKey: PropertyKey.PreviousProgress)
        aCoder.encode(Note, forKey: PropertyKey.Note)
        aCoder.encode(length, forKey: PropertyKey.length)
        
    }
    
   
    
    //MARK: Types
    
    struct PropertyKey {
        static let name="name"
        static let cover="cover"
        static let currentLine="currentLIne"
        static let chapterList="chapterList"
        static let markList="markList"
        static let keywordList="keywordList"
        static let PreviousProgress="PreiousProgress"
        static let Note="Note"
        static let length="length"
        
    }
    
}
