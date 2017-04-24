//
//  ComposeTweetViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

protocol ComposeTweetProtocol {
    func addNewTweet(tweet: Tweet)
}

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var newTweetView: ComposeTweet!
    @IBOutlet weak var newTweetTextView: UITextView!
    @IBOutlet weak var charactersRemaining: UILabel!
    @IBOutlet weak var onTweetButton: UIBarButtonItem!
    
    var delegate: ComposeTweetProtocol? = nil
    var newTweet: Tweet?
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        TwitterClient.sharedInstance.sendTweet(text: newTweetTextView.text, success: { (newTweet: Tweet) -> () in
            self.newTweet = newTweet
            self.delegate?.addNewTweet(tweet: self.newTweet!)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let length = textView.text.characters.count
        let remaining = 140 - length
        charactersRemaining.text = "\(remaining)"
        if length > 140 {
            charactersRemaining.textColor = UIColor.red
            onTweetButton.isEnabled = false
        } else {
            charactersRemaining.textColor = UIColor.gray
            onTweetButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTweetTextView.delegate = self
        newTweetTextView.becomeFirstResponder()
        newTweetView.loadUserData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
