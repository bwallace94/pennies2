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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "bHx4PtFd6xIjBgPzUw1fRf54j", consumerSecret: "Z3RzbZVZhqvso9VVKKMbcoAGuP1Cqq3RlOinxhCVyurkNKyCu4")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "pennies://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Token acquired!")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
        }) { (error: Error!) -> Void in
            print("Error")
        }
    }

}
