//
//  chapterTableViewCell.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class chapterTableViewCell: UITableViewCell {

    
   // @IBOutlet weak var chapterNum: UILabel!
    @IBOutlet weak var chapterProgress: UILabel!
    @IBOutlet weak var chapterName: UILabel!
    var baseDelegate: baseViewDelegate!
    var Location=NSMakeRange(0,0)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
     
        super.setSelected(selected, animated: animated)
      
        // Configure the view for the selected state
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
         baseDelegate.backToLocation(Location)
    }  
    
 
  
  
   
    
}
