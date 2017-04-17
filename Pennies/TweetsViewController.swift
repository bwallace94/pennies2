//
//  TweetsViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]!

    @IBAction func onSignOutButton(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            //tableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
        TwitterClient.sharedInstance.currentAccount(success: { (user: User) in
            //TODO
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
