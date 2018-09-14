//
//  SecondViewController.swift
//  Waterfly
//
//  Created by Bhuvan on 13/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    var username : String = ""
    var password : String = ""
    
    let CONNECTION_REFUSED = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">\n<title>401 Unauthorized</title>\n<h1>Unauthorized</h1>\n<p>The server could not verify that you are authorized to access the URL requested.  You either supplied the wrong credentials (e.g. a bad password), or your browser doesn't understand how to supply the credentials required.</p>\n"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        username = usernameTextField.text ?? ""
        password = passwordTextField.text ?? ""
        if username == "" || password == "" {
            infoLabel.text = "Please enter a username and password."
        }
        else {
            performSegue(withIdentifier: "loading", sender:"")
        }
    }
    
}

