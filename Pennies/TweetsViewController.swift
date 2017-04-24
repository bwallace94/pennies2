//
//  TweetsViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeTweetProtocol {
    
    var tweets: [Tweet]! = []
    var sendUserID = ""
    var mentions = false
    var home = true

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSignOutButton(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweetInfo = tweets[indexPath.row]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (onTapProfileImageView(_:)))
        cell.userProfilePictureImageView.isUserInteractionEnabled = true
        cell.userProfilePictureImageView.addGestureRecognizer(tapGesture)
        cell.userProfilePictureImageView.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func refreshControlAction(_refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            _refreshControl.endRefreshing()
            self.tableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
            _refreshControl.endRefreshing()
        })
    }
    
    func addNewTweet(tweet newTweet: Tweet) {
        tweets = [newTweet] + tweets
        tableView.reloadData()
    }
    
    func onTapProfileImageView(_ sender: UITapGestureRecognizer) {
        let profileImage = sender.view as! UIImageView
        let row = profileImage.tag
        sendUserID = tweets[row].user_id!
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        if mentions {
            TwitterClient.sharedInstance.mentionsTimeline(success: { (tweets:[Tweet]) in
                self.navigationController?.navigationBar.topItem?.title = "Mentions"
                self.tweets = tweets
                self.tableView.reloadData()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        } else {
            TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        TwitterClient.sharedInstance.currentAccount(success: { (user: User) in
            //TODO
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            let indexPath = tableView.indexPath(for: sender as! TweetCell)!
            let vc = segue.destination as! TweetDetailsViewController
            vc.tweetInfo = tweets[indexPath.row]
        }
        if segue.identifier == "newTweetSegue" {
            let navController = segue.destination as! UINavigationController
            let vc = navController.childViewControllers.first as! ComposeTweetViewController
            vc.delegate = self
        }
        if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileViewController
            vc.userID = sendUserID
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
