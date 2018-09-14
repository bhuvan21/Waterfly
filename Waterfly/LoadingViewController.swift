//
//  LoadingViewController.swift
//  Waterfly
//
//  Created by Bhuvan on 13/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //json_request()
    }
    
    /*
     TO BE FIXED
    func json_request(_ url:String, localusername: String, localpassword: String)
    {
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        username = localusername
        password = localpassword
        let paramString = "username=" + localusername + "&password=" + localpassword
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                if dataString as String == self.CONNECTION_REFUSED {
                    self.message.text = "Please Enter a valid login."
                }
                else {
                    let dataFromString = dataString.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
                    ALL = JSON(data: dataFromString!)
                    
                    self.mainJSONString = dataString
                    self.buttonActive = !self.buttonActive
                    print(ALL)
                    print("Done!")
                    self.yeetboi()
                }
                self.buttonActive = !self.buttonActive
                self.activity.stopAnimating()
            }
            
        }
        
        task.resume()
    }*/

}
