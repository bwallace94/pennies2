//
//  ProfileView.swift
//  Pennies
//
//  Created by Bria Wallace on 4/23/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var numberFollowersLabel: UILabel!
    @IBOutlet weak var numberFollowingLabel: UILabel!
    
    var user: User! {
        didSet {
            if let bannerUrl = user.profileBannerUrl {
                bannerImageView.setImageWith(bannerUrl)
            }
            if let profileUrl = user.profileUrl {
                profileImageView.setImageWith(profileUrl)
            }
            nameLabel.text = user.name
            screennameLabel.text = "@\(user.screenname!)"
            numberTweetsLabel.text = user.numberTweets
            numberFollowersLabel.text = user.numberFollowers
            numberFollowingLabel.text = user.numberFollowing
        }
    }
}
