//
//  Tweet.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var name: String?
    var screenname: String?
    var text: String?
    var profilePictureUrl: URL?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var timestamp: Date?
    
    init(dict: NSDictionary) {
        let user = dict["user"] as? NSDictionary
        if let user = user {
            name = user["name"] as? String
            screenname = user["screen_name"] as? String
            let urlString = user["profile_image_url_https"] as? String
            if let urlString = urlString {
                profilePictureUrl = URL(string: urlString)
            }
        }
        text = dict["text"] as? String
        retweetCount = (dict["retweet_count"] as? Int) ?? 0
        favoriteCount = (dict["favorite_count"] as? Int) ?? 0
        let timestampString = dict["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
    }
    
    class func tweetsWithArray(dicts: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for d in dicts {
            let tweet = Tweet(dict: d)
            tweets.append(tweet)
        }
        return tweets
    }
}
