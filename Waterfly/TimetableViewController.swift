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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return INFO["timetable"][dayIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timetablecell", for: indexPath) //as! LessonCell
        
        return cell
    }
    

    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    

}
