//
//  TweetDetailsViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    @IBOutlet var tweetView: TweetDetails!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweetInfo: Tweet!

    @IBAction func onReplyButton(_ sender: Any) {
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        TwitterClient.sharedInstance.retweetTweet(tweetID: tweetInfo.id, success: { (tweet: Tweet) in
            let previous = Int(self.tweetView.retweetNumberLabel.text!)
            self.tweetView.retweetNumberLabel.text = "\(previous! + 1)"
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        TwitterClient.sharedInstance.favoriteTweet(tweetID: tweetInfo.id, success: { (tweet: Tweet) in
            let previous = Int(self.tweetView.favoritesNumberLabel.text!)
            self.tweetView.favoritesNumberLabel.text = "\(previous! + 1)"
            self.favoriteButton.setImage(#imageLiteral(resourceName: "like-action-on"), for: .normal)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileViewController
            vc.userID = tweetInfo.user_id
        }
    }
    
    func onTapProfileImageView(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    func sendTweetView(tweet: Tweet) {
        tweetView.tweetDetails = tweetInfo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (onTapProfileImageView(_:)))
        tweetView.userProfilePictureImageView.addGestureRecognizer(tapGesture)
    }
    
    func sendUpdatedTweetView(tweet: Tweet) {
        tweetView.tweetUpdatedDetails = tweet
    }
    
    func getUpdatedStats() {
        TwitterClient.sharedInstance.getTweetByID(tweetID: tweetInfo.id!, success: { (tweet: Tweet) in
            self.sendUpdatedTweetView(tweet: tweet)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tweetInfo.favorited {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "like-action-on"), for: .normal)
        }
        sendTweetView(tweet: tweetInfo)
        getUpdatedStats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
