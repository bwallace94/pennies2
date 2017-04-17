//
//  TweetDetails.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class TweetDetails: UIView {

    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetNumberLabel: UILabel!
    @IBOutlet weak var favoritesNumberLabel: UILabel!

    var tweetDetails:Tweet! {
        didSet {
            userProfilePictureImageView.setImageWith(tweetDetails.profilePictureUrl!)
            userNameLabel.text = tweetDetails.name
            userTextLabel.text = tweetDetails.text
            userScreennameLabel.text = tweetDetails.screenname
            retweetNumberLabel.text = ("\(tweetDetails.retweetCount)")
            favoritesNumberLabel.text = ("\(tweetDetails.favoriteCount)")
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy, hh:mm a"
            timestampLabel.text = formatter.string(from: tweetDetails.timestamp!)
        }
    }
}
