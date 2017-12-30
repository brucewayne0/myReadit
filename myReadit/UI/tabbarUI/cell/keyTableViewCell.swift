//
//  kwTableViewCell.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class kwTableViewCell: UITableViewCell {
    @IBOutlet weak var DeleteButtom: UIButton!
    
    @IBOutlet weak var Keyword: UILabel!
    var node:KeyNode!
    var baseDelegate: baseViewDelegate!
    var tableDelegate: tableDelegate!
    var index:Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            baseDelegate.showKeyword(node)
    
    }
    @IBAction func deleteAction(_ sender: Any) {
        
        
        baseDelegate.getbook().keywordList.remove(at:  self.index)
        
        tableDelegate.remove(at:  self.index)
        
        
        
    }

   
}
