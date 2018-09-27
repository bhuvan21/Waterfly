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

    var dayIndex : Int = 0
    
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
        
        return cell
    }
    

    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    

}
