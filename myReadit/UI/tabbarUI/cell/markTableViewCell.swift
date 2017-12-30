//
//  bkTableViewCell.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class bkTableViewCell: UITableViewCell {

    
    
  
    @IBOutlet weak var DeleteButtom: UIButton!
    @IBOutlet weak var Content: UILabel!
    @IBOutlet weak var Progress: UILabel!
    var index:Int!
    var baseDelegate: baseViewDelegate!
    var tableDelegate: tableDelegate!
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

    
    @IBAction func deleteAction(_ sender: Any) {
       
        
         baseDelegate.getbook().markList.remove(at:  self.index)
      
        tableDelegate.remove(at:  self.index)
     
        
    
    }
}
