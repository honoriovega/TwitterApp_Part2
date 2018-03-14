//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Honorio Vega on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}


class ComposeViewController: UIViewController,UITextViewDelegate {
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var tweetCharacterCount: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var userPictureImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        

        
        nameTextField.text = User.current?.name
        usernameTextField.text = User.current?.screenName
        
        let profilePictureURL = URL(string: (User.current?.profileImageLink)!)
        userPictureImageview.af_setImage(withURL: profilePictureURL!)
        self.tweetTextView.layer.borderWidth = 1.0;
        self.tweetTextView.layer.borderColor = UIColor.black.cgColor
        
        // make the cursor be in the textview
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func didTapTweet(_ sender: Any) {
        
        
        
        let tweetMsg = tweetTextView.text ?? "nothing"
     APIManager.shared.composeTweet(with: tweetMsg) { (tweet, error) in
           if let error = error {
              print("Error composing Tweet: \(error.localizedDescription)")           } else if let tweet = tweet {              self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            self.dismiss(animated: true, completion: nil)

           }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        let text = tweetTextView.text as! String
        tweetCharacterCount.text = "\(140 - text.count)"
        print(textView.text); //the textView parameter is the textView where text was changed
        
    
    }
    
  
    
}
