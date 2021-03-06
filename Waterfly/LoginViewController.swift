//
//  SecondViewController.swift
//  Waterfly
//
//  Created by Bhuvan on 13/09/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    var username : String = ""
    var password : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APPGROUP!.synchronize()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (APPGROUP!.string(forKey: "username") != nil) {
            performSegue(withIdentifier: "loading", sender: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        username = usernameTextField.text ?? ""
        password = passwordTextField.text ?? ""
        if username == "" || password == "" {
            infoLabel.text = "Please enter a username and password."
        }
        else {
            APPGROUP!.set(username, forKey:"username")
            APPGROUP!.set(password, forKey:"password")
            APPGROUP!.synchronize()
            
            performSegue(withIdentifier: "loading", sender: nil)
        }
    }
    
}

