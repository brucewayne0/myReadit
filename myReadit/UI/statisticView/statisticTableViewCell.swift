//
//  StatisticTableViewCell.swift
//  myReadit
//
//  Created by 江南 on 2017/12/8.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
