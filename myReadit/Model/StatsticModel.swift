//
//  StatsticModel.swift
//  myReadit
//
//  Created by 江南 on 2017/12/8.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import Foundation
import os.log

class StatisticNode:NSObject,NSCoding{
    var time:Int//阅读总时间
    var date:NSDate
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("statistics")
    
    init?(_ time: Int,_ date: NSDate)
    {
        self.time=time
        self.date=date
     
    }
    struct PropertyKey {
        static let  time="time"
        static let date="date"
       
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(date, forKey: PropertyKey.date)
     
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        let time = aDecoder.decodeInteger(forKey: PropertyKey.time)
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as! NSDate
      
        self.init(time,date)
    }
    
    
    
}
