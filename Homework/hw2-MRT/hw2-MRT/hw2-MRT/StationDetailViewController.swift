//
//  StationDetailViewController.swift
//  hw2-MRT
//
//  Created by denniswang on 2016/5/19.
//  Copyright © 2016年 dwnnis. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {
    
    @IBOutlet weak var detailStationNameLabel: UILabel!
    @IBOutlet weak var detailLineLabel: UILabel!
    @IBOutlet weak var detailLineLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateValue()
    }
    
    var station: Station? {
        didSet {
            if self.isViewLoaded() {
                self.updateValue()
            }
        }
    }
    
    func updateValue() {
        guard let station = self.station else {
            return
        }
        self.detailStationNameLabel.text = station.name
        self.title = station.name
        
        let keys = [String](station.line.keys)
        
        if (keys.count == 2) {
            self.detailLineLabel.text = keys[0]
            self.detailLineLabel.textColor = UIColor.whiteColor()
            self.detailLineLabel.backgroundColor = pickStationColor(keys[0])
            self.detailLineLabel2.text = keys[1]
            self.detailLineLabel2.textColor = UIColor.whiteColor()
            self.detailLineLabel2.backgroundColor = pickStationColor(keys[1])
            self.detailLineLabel2.hidden = false
        } else {
            self.detailLineLabel.text = keys[0]
            self.detailLineLabel.textColor = UIColor.whiteColor()
            self.detailLineLabel.backgroundColor = pickStationColor(keys[0])
            self.detailLineLabel2.hidden = true
        }
    }
}
