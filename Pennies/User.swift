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
    
    init(dict: NSDictionary) {
        name = dict["name"] as? String
        screenname = dict["screen_name"] as? String
        let profileUrlString = dict["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        tagline = dict["description"] as? String
    }
}
