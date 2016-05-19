//
//  MRTTableViewCell.swift
//  hw2-MRT
//
//  Created by denniswang on 2016/5/19.
//  Copyright © 2016年 dwnnis. All rights reserved.
//

import UIKit

class MRTTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationLineStackView: UIStackView!
    @IBOutlet weak var stationLineLabel: UILabel!
    @IBOutlet weak var stationLineLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
