//
//  Tweet.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var timestamp: Date?
    
    init(dict: NSDictionary) {
        text = dict["text"] as? String
        retweetCount = (dict["retweet_count"] as? Int) ?? 0
        favoriteCount = (dict["favourites_count"] as? Int) ?? 0
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
