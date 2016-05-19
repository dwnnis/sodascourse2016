//
//  StationData.swift
//  hw2-MRT
//
//  Created by denniswang on 2016/5/19.
//  Copyright © 2016年 dwnnis. All rights reserved.
//

import Foundation
import ObjectMapper

struct Station {

    var name: String!
    var coordinate: [Double]!
    var line: [String: String]!
    
}

struct Line {

    var name: String
    var stations: [Station]
}

extension Station: Mappable {

    init?(_ map: Map) {
    }
    mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.coordinate <- map["coordinate"]
        self.line <- map["lines"]
    }
}

func pickStationColor (lineName: String) -> UIColor {
    switch lineName {
    case "文湖線":
        return UIColor(red: 158.0/255.0, green: 101.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    case "淡水信義線":
        return UIColor(red: 203.0/255.0, green: 44.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    case "新北投支線":
        return UIColor(red: 248.0/255.0, green: 144.0/255.0, blue: 165.0/255.0, alpha: 1.0)
    case "松山新店線":
        return UIColor(red: 0.0/255.0, green: 119.0/255.0, blue: 73.0/255.0, alpha: 1.0)
    case "小碧潭支線":
        return UIColor(red: 206.0/255.0, green: 220.0/255.0, blue: 0.0, alpha: 1.0)
    case "中和新蘆線":
        return UIColor(red: 255.0/255.0, green: 163.0/255.0, blue: 0.0, alpha: 1.0)
    case "板南線":
        return UIColor(red: 0.0, green: 94.0/255.0, blue: 184.0/255.0, alpha: 1.0)
    case "貓空纜車":
        return UIColor(red: 119.0/255.0, green: 185.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    default:
        return UIColor.blackColor()
    }
}