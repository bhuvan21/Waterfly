//
//  TodayViewController.swift
//  Timetable
//
//  Created by Atto Allas on 27/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit
import NotificationCenter
import SwiftyJSON

let APPGROUP = UserDefaults(suiteName: "group.com.bekos.WaterflyIOS")

let sizeOfRow = 50

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {

    let timeFormatter = DateFormatter()
    
    let timetableData = (APPGROUP!.object(forKey: "timetableData") as! Array<Array<String>>).map {$0.map {JSON.init(parseJSON: $0)} }
    
    // Starts on Sunday _and_ is 1 indexed
    var dayIndex: Int = Calendar(identifier: .iso8601).component(.weekday, from: Date())-2

    @IBOutlet weak var lessonTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "HH:mm"
    
        if dayIndex == -1 {
            dayIndex = 6
        }
        
        preferredContentSize = CGSize(width: 0, height: min(Int(preferredContentSize.height), timetableData[dayIndex].count*sizeOfRow))
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        lessonTableView.delegate = self
        lessonTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(timetableData[dayIndex].count, Int(preferredContentSize.height)/sizeOfRow)
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
        
        if (indexPath.row == min(timetableData[dayIndex].count, Int(preferredContentSize.height)/sizeOfRow-1)) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
        } else {
            cell.separatorInset = UIEdgeInsets()
        }
        
        return cell
    }
    
    func isBetweenDate(_ date: Date, isBetweenDate beginDate: Date, andDate endDate: Date) -> Bool {
        if (date.compare(beginDate) == .orderedAscending || date.compare(endDate) != .orderedAscending) {
            return false
        }
        return true
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        preferredContentSize = maxSize
        if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: 0, height: min(Int(maxSize.height), timetableData[dayIndex].count*sizeOfRow))
        } else {
            preferredContentSize = maxSize
        }
        
        lessonTableView.reloadData()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        // Starts on Sunday _and_ is 1 indexed
        var possibleDayIndex = Calendar(identifier: .iso8601).component(.weekday, from: Date())-2
        if possibleDayIndex == -1 {
            possibleDayIndex = 6
        }
        dayIndex = possibleDayIndex
        
        lessonTableView.reloadData()
        completionHandler(NCUpdateResult.newData)
    }
    
}
