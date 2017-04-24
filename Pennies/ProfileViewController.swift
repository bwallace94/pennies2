//
//  ProfileViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/23/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var profileView: ProfileView!
    @IBOutlet weak var tableView: UITableView!
    
    var userDetails: User!
    var userID = User.currentUser?.id
    var userTweets:[Tweet]! = []
    
    func setUserDetails() {
        profileView.user = userDetails
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweetInfo = userTweets[indexPath.row]
        return cell
    }
    
    func loadData() {
        TwitterClient.sharedInstance.userAccount(userID: userID, success: { (user: User) in
            self.userDetails = user
            self.setUserDetails()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        TwitterClient.sharedInstance.userTimeline(userID: userID, success: { (tweets: [Tweet]) in
            self.userTweets = tweets
            self.tableView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
