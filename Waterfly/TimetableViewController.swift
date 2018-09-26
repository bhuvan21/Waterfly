//
//  TimetableViewController.swift
//  Waterfly
//
//  Created by Bhuvan on 13/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dayIndex : Int = 0
    
    @IBAction func dayValueChanged(_ sender: UISegmentedControl) {
        dayIndex = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return INFO["timetable"][dayIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        cell.LessonLabel.text = INFO["timetable"][dayIndex][indexPath.row]["subject"].string
        
        return cell
    }
    

    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    

}
