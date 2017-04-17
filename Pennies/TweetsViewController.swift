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

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSignOutButton(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweetInfo = tweets[indexPath.row]
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
        print("HERE2")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
