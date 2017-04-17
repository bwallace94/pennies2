//
//  TweetCell.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweetInfo: Tweet! {
        didSet {
            userNameLabel.text = tweetInfo.name
            userScreennameLabel.text = "@\(tweetInfo.screenname!)"
            tweetTextLabel.text = tweetInfo.text
            if let url = tweetInfo.profilePictureUrl {
                userProfilePictureImageView.setImageWith(url)
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            timestampLabel.text = formatter.string(from: tweetInfo.timestamp!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


