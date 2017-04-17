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
    
    var tweetInfo: Tweet!

    func sendTweetView(tweet: Tweet) {
        tweetView.tweetDetails = tweetInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendTweetView(tweet: tweetInfo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
