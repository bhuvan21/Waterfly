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

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var LessonName: UILabel!
    @IBOutlet weak var LessonTime: UILabel!
    
    let APPGROUP = UserDefaults(suiteName: "group.com.bekos.WaterflyIOS")
    
    @IBAction func refreshButton_touchUpInside(_ sender: Any) {
        guard let infoString = APPGROUP!.string(forKey: "info") else {
            print("Info nil")
            return
        }
        
        let info = JSON.init(parseJSON: infoString)
        
        print(info)
        
        LessonName.text = info["timetable"][0][0]["subject"].string
        LessonTime.text = (info["timetable"][0][0]["time"].string ?? "unknown") + "-" + (info["timetable"][0][0]["endtime"].string ?? "unknown")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        do {
            if APPGROUP!.data(forKey: "data") == nil {
                completionHandler(NCUpdateResult.noData)
                return
            }

            let info = try JSON.init(data: APPGROUP!.data(forKey: "data")!)
            
            print(info)
            
            LessonName.text = info["timetable"][0][0]["subject"].string
            LessonTime.text = (info["timetable"][0][0]["time"].string ?? "unknown") + "-" + (info["timetable"][0][0]["endtime"].string ?? "unknown")
    
            completionHandler(NCUpdateResult.newData)
        } catch {
            completionHandler(NCUpdateResult.failed)
        }
    }
    
}
