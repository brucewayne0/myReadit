//
//  ContentParse.swift
//  myReadit
//
//  Created by 江南 on 2017/11/28.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import Foundation
import UIKit
import CoreText

//文本解析
func EncodeURL(_ url:URL) ->String {
    
    var content = ""
    
    // 检查URL是否有值
    if url.absoluteString.isEmpty {
        
        return content
    }
    
    // NSUTF8StringEncoding 解析
    content = EncodeURL(url, encoding: String.Encoding.utf8.rawValue)
    
    if content.isEmpty {
        
        content = EncodeURL(url, encoding: 0x80000632)
    }
    
    if content.isEmpty {
        
        content = EncodeURL(url, encoding: 0x80000930)
    }
    if content.isEmpty {
        
        content = EncodeURL(url, encoding: String.Encoding.unicode.rawValue)
    }
    if content.isEmpty {
        
        content = ""
    }
    
    return content
}


private func EncodeURL(_ url:URL,encoding:UInt) ->String {
    
    do{
        return try NSString(contentsOf: url, encoding: encoding) as String
        
    }catch{}
    
    return ""
}
func ChapterParse(_ content: String,_ book:Book)
{
    book.chapterList.removeAll()
    let parten1="第[0-9一二三四五六七八九十百千]*[.章节部] .*"
    ChapterParseWithPattern(content,book,parten1)
    if (book.chapterList.count != 0)
    { return ;}
    else{
        let parten2="Chapter[0-9]* .*"
        ChapterParseWithPattern(content,book,parten2)
    }
    
}
func ChapterParseWithPattern(_ content: String,_ book:Book, _ parten: String)
{
 
    var results:[NSTextCheckingResult] = []
    do{
        let regularExpression:NSRegularExpression = try NSRegularExpression(pattern: parten, options: NSRegularExpression.Options.caseInsensitive)
        
        results = regularExpression.matches(in: content, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: content.length))
        
    }catch{
        let node=ChapterNode(0,"开始",NSMakeRange(0, 0),0.0)
       
       
        book.chapterList.append(node!)
        return
    }
     if !results.isEmpty {
        
   
        let count=results.count
        
        
        for i in 0..<count{
        
            let node=ChapterNode(i+1,content.substring(results[i].range),results[i].range,Float(results[i].range.lowerBound)/Float(content.length))
         
            book.chapterList.append(node!)
        }
    }
}






