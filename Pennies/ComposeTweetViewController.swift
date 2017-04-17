//
//  ComposeTweetViewController.swift
//  Pennies
//
//  Created by Bria Wallace on 4/16/17.
//  Copyright © 2017 Bria Wallace. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var newTweetTextView: UITextView!
    @IBOutlet weak var charactersRemaining: UILabel!
    @IBOutlet weak var onTweetButton: UIBarButtonItem!
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        TwitterClient.sharedInstance.sendTweet(text: newTweetTextView.text, success: { 
            print("TWEET POSTED")
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if textView.text.characters.count == 140 && !(text != "") {
//            return false
//        }
//        return true
//    }
    
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
