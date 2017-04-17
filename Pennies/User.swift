//
//  User.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    var userDictionary: NSDictionary?
    
    init(dict: NSDictionary) {
        userDictionary = dict
        name = dict["name"] as? String
        screenname = dict["screen_name"] as? String
        let profileUrlString = dict["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        tagline = dict["description"] as? String
    }
    
    static let UserDidLogoutNotification = NSNotification.Name.init(rawValue: "UserDidLogout")
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                if let userData = userData {
                    print(userData)
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dict: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.userDictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
                print(data)
                defaults.synchronize()
            } else {
                defaults.removeObject(forKey: "currentUserData")
                defaults.synchronize()
            }
        }
    }
}
