//
//  TimetableViewController.swift
//  Waterfly
//
//  Created by Bhuvan on 13/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit
import SwiftyJSON

class TimetableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Starts on Sunday _and_ is 1 indexed
    var dayIndex : Int = Calendar(identifier: .iso8601).component(.weekday, from: Date())-2
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var daySegmentControl: UISegmentedControl!
    
    let timeFormatter = DateFormatter()
    
    // Basically undoes the JSON encoding done in the saving stap
    let timetableData = (APPGROUP!.object(forKey: "timetableData") as! Array<Array<String>>).map {$0.map {JSON.init(parseJSON: $0)} }
    
    @IBAction func dayValueChanged(_ sender: UISegmentedControl) {
        dayIndex = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableData[dayIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        cell.LessonLabel.text = timetableData[dayIndex][indexPath.row]["subject"].string
        cell.LessonTimeLabel.text = (timetableData[dayIndex][indexPath.row]["time"].string ?? "unknown") + "-" + (timetableData[dayIndex][indexPath.row]["endtime"].string ?? "unknown")
        
        let startDate = timeFormatter.date(from: timetableData[dayIndex][indexPath.row]["time"].string ?? "00:00")
        let endDate = timeFormatter.date(from: timetableData[dayIndex][indexPath.row]["endtime"].string ?? "00:00")
        
        let todayDate = timeFormatter.date(from: "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))")
        
        if isBetweenDate(todayDate!, isBetweenDate: startDate!, andDate: endDate!) {
            cell.LessonLabel.font = UIFont.boldSystemFont(ofSize: 17)
            cell.LessonTimeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        } else {
            cell.LessonLabel.font = UIFont.systemFont(ofSize: 17)
            cell.LessonTimeLabel.font = UIFont.systemFont(ofSize: 17)
        }
        
        return cell
    }
    
    func isBetweenDate(_ date: Date, isBetweenDate beginDate: Date, andDate endDate: Date) -> Bool {
        if (date.compare(beginDate) == .orderedAscending || date.compare(endDate) != .orderedAscending) {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "HH:mm"

        // If it's Sunday, sets it to Monday
        if dayIndex == -1 {
            dayIndex = 0
        }
        
        daySegmentControl.selectedSegmentIndex = dayIndex
    }
    

    

}
