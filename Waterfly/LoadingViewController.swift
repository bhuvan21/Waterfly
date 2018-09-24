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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                self.performSegue(withIdentifier: "backtologin", sender: "")
                return
            }
            do {
                try INFO = JSON.init(data: data!)
            }
            catch {
                self.performSegue(withIdentifier: "backtologin", sender: "")
            }

            print(INFO)
        }
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtologin" {
            if let dest = segue.destination as? LoginViewController {
                dest.infoLabel.text = "An error occurred."
            }
        }
    }

}
