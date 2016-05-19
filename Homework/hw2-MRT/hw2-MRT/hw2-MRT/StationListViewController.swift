//
//  StationListViewController.swift
//  hw2-MRT
//
//  Created by denniswang on 2016/5/19.
//  Copyright © 2016年 dwnnis. All rights reserved.
//

import UIKit
import ObjectMapper

class StationListViewController: UITableViewController {

    var station: [Station]!
    var lines: [Line]!
    
    var lineDict: [String: [Station]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load json file
        let dataPath = NSBundle.mainBundle().pathForResource("MRT", ofType: "json")!
        let MRTStationSource = try! String(contentsOfFile: dataPath)
        
        // mapper
        self.station = Mapper<Station>().mapArray(MRTStationSource)
        
        // create dictionary for lines
        for stationName in station {
            for lineName in stationName.line.keys {
                if(self.lineDict[lineName] == nil){
                    self.lineDict[lineName] = []
                }
                self.lineDict[lineName]!.append(stationName)
            }
        }
        
        // use line dict to create line array
        self.lines = []
        
        for (lineName, stations) in lineDict {
            self.lines.append(Line(name: lineName, stations: stations))
        }
        
        // sort the station by number
        for index in 0...(lines.count-1) {
            let lineName = lines[index].name
            lines[index].stations = lines[index].stations.sort {(stationA: Station, stationB: Station) -> Bool in
                return stationA.line[lineName] < stationB.line[lineName]
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.lines.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.lines[section].name
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lines[section].stations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StationCell", forIndexPath: indexPath) as! MRTTableViewCell
        let station = self.lines[indexPath.section].stations[indexPath.row]
        
        let keys = [String](station.line.keys)
        
        cell.stationNameLabel.text = station.name
        
        if (keys.count == 2) {
            cell.stationLineLabel.text = station.line[keys[1]]
            cell.stationLineLabel.textColor = UIColor.whiteColor()
            cell.stationLineLabel.backgroundColor = pickStationColor(keys[1])
            cell.stationLineLabel2.text = station.line[keys[0]]
            cell.stationLineLabel2.textColor = UIColor.whiteColor()
            cell.stationLineLabel2.backgroundColor = pickStationColor(keys[0])
            cell.stationLineLabel2.alpha = 1.0
        } else {
            cell.stationLineLabel.text = station.line[keys[0]]
            cell.stationLineLabel.textColor = UIColor.whiteColor()
            cell.stationLineLabel.backgroundColor = pickStationColor(keys[0])
            cell.stationLineLabel2.alpha = 0.0
        }
        
        cell.stationLineLabel.layer.masksToBounds = true
        cell.stationLineLabel.layer.cornerRadius = 6.0
        cell.stationLineLabel2.layer.masksToBounds = true
        cell.stationLineLabel2.layer.cornerRadius = 6.0
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        if segueIdentifier == "ShowStationDetail" {
            
            guard let stationDetailViewController = segue.destinationViewController as? StationDetailViewController else {
                return
            }
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let station = self.lines[indexPath.section].stations[indexPath.row]
            
            stationDetailViewController.station = station
        }
    }
    
}



