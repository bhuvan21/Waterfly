//
//  LoadingViewController.swift
//  Waterfly
//
//  Created by Bhuvan on 13/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoadingViewController: UIViewController {

    var username : String = ""
    var password : String = ""
    
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityIndicator.startAnimating()

        username = APPGROUP!.string(forKey: "username")!
        password = APPGROUP!.string(forKey: "password")!
        
        let url = URL(string: "https://firefly-server.herokuapp.com/summary")!
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = String(describing:"username=" + username + "&password=" + password).data(using: .utf8)
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "backtologin", sender: "")
                }
                return
            }
            do {
                try INFO = JSON.init(data: data!)
                
                APPGROUP!.set(INFO.rawString(), forKey: "info")
                APPGROUP!.synchronize()
                
                let inFormatter = DateFormatter()
                inFormatter.locale = Locale(identifier: "en_US_POSIX")
                inFormatter.dateFormat = "HH:mm"
                
                var timetableData: Array<Array<JSON>> = []
                
                for dayIndex in 0...INFO["timetable"].array!.count-1 {
                    var lastSubject = ""
                    
                    let day = INFO["timetable"][dayIndex]
                    timetableData.append([])
                    
                    if day.array!.count == 0 {
                        continue
                    }
                    
                    for lessonIndex in 0...day.array!.count-1 {
                        let lesson = day[lessonIndex]
                        
                        // Ok, what this horrendous things does is:
                        // It checks whether it's subject name is the same as the lesson that preceeded it
                        // It checks whether that lesson occurs precisely 5 mins after the former lesson
                        // If both of these are true, it's a valid double lesson, otherwise, it's not
                        if lessonIndex > 0 && lessonIndex+1 != day.array!.count && Calendar.current.dateComponents([.minute], from: inFormatter.date(from: day[lessonIndex-1]["endtime"].string!)!, to: inFormatter.date(from: lesson["time"].string!)!).minute! > 5 {
                            timetableData[dayIndex].append(JSON(parseJSON: "{\"subject\":\"Break\", \"time\":\"\(day[lessonIndex-1]["endtime"])\",\"endtime\":\"\(day[lessonIndex]["time"])\"}"))
                            lastSubject = "Break"
                        }
                        if lesson["subject"].string! == lastSubject {
                            timetableData[dayIndex][timetableData[dayIndex].count-1]["endtime"] = lesson["endtime"]
                        } else {
                            timetableData[dayIndex].append(lesson)
                            lastSubject = lesson["subject"].string!
                        }
                    }
                }
                
                APPGROUP!.set(timetableData.map { $0.map {$0.rawString()} }, forKey: "timetableData")
                APPGROUP!.synchronize()
            }
            catch {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "backtologin", sender: "")
                }
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "gotdata", sender: "")
            }
            
        }
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtologin" {
            if let dest = segue.destination as? LoginViewController {
                dest.infoLabel.text = "An error occurred."
            }
        }
    }

}
