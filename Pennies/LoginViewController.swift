//
//  LoginViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/15/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance.login(success: {
            print("Logged In")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
}
