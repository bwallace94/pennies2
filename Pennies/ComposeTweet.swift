//
//  ComposeTweet.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class ComposeTweet: UIView {

    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var newTweetTextView: UITextView!
    
    func loadUserData() {
        let user = User.currentUser!
        userProfilePictureImageView.setImageWith(user.profileUrl!)
        userNameLabel.text = user.name
        userScreennameLabel.text = user.screenname
    }
}
