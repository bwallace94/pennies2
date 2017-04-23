//
//  TwitterClient.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "bHx4PtFd6xIjBgPzUw1fRf54j", consumerSecret: "Z3RzbZVZhqvso9VVKKMbcoAGuP1Cqq3RlOinxhCVyurkNKyCu4")!
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "pennies://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }) { (error: Error!) -> Void in
            print(error.localizedDescription)
            self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: User.UserDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            self.loginSuccess?()
        }) { (error: Error!) -> Void in
            self.loginFailure?(error)
            print("\(error.localizedDescription)")
        }
    }

    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dicts = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dicts: dicts)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDict = response as! NSDictionary
            let user = User(dict: userDict)
            success(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func sendTweet(text: String!, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        var parameters = [String: String]()
        parameters["status"] = text
        post("1.1/statuses/update.json", parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dict: dictionary)
            success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR SENDING TWEET")
            failure(error)
        }
    }
    
    func favoriteTweet(tweetID: String!, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        var parameters = [String: String]()
        parameters["id"] = tweetID
        post("1.1/favorites/create.json", parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dict: dictionary)
            success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR FAVORITING TWEET")
            failure(error)
        }
    }
    
    func unfavoriteTweet(tweetID: String!, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        var parameters = [String: String]()
        parameters["id"] = tweetID
        post("1.1/favorites/destroy.json", parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dict: dictionary)
            success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR UNFAVORITING TWEET")
            failure(error)
        }
    }
    
    func retweetTweet(tweetID: String!, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let urlString = "1.1/statuses/retweet/\(tweetID!).json"
        post(urlString, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dict: dictionary)
            success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR RETWEETING")
            failure(error)
        }
    }
}
