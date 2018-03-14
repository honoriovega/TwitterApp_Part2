//
//  DetailTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Honorio Vega on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    var tweet : Tweet?

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var numRetweetsLabel: UILabel!
    
    @IBOutlet weak var numFavoritesLabel: UILabel!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            let profilePicURL = tweet.user.profileImageLink as! String
            profilePicImageView.af_setImage(withURL: URL(string: profilePicURL)!)
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@\(tweet.user.screenName as! String)"
            tweetLabel.text = tweet.text
            dateTimeLabel.text = tweet.createdAtTimeAndDateString
            numRetweetsLabel.text = "\(tweet.retweetCount as! Int)"
            numFavoritesLabel.text = "\(tweet.favoriteCount as! Int)"
            
            if(tweet.favorited!) {
                let image = UIImage(named: "favor-icon-red")
                favoriteButton.setImage(image, for: UIControlState.normal)
            }
            
            if(tweet.retweeted) {
                let image = UIImage(named: "retweet-icon-green")
                self.retweetButton.setImage(image, for: UIControlState.normal)
            }
            
//            var id: Int64 // For favoriting, retweeting & replying
//            var text: String // Text content of tweet
//            var favoriteCount: Int? // Update favorite count label
//            var favorited: Bool? // Configure favorite button
//            var retweetCount: Int // Update favorite count label
//            var retweeted: Bool // Configure retweet button
//            var user: User // Contains name, screenname, etc. of tweet author
//            var createdAtString: String // Display date
//            
//            var name: String
//            var screenName: String?
//            var profileImageLink: String?
            
        }

        // Do any additional setup after loading the view.
    }
 
    @IBAction func didTapFavorite(_ sender: UIButton) {

        // if it's favorited
        if(tweet?.favorited!)! {
            
            tweet?.favorited = false
            if(tweet?.favoriteCount! != 0 ) {
                tweet?.favoriteCount! -= 1
                
            }
            
            // then unfavorite it
            APIManager.shared.unFavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorite the following Tweet: \n\(tweet.text)")
                    
                    let image = UIImage(named: "favor-icon")
                    self.favoriteButton.setImage(image, for: UIControlState.normal)
                }
            }
            
        } else {
            tweet?.favorited = true
            
            tweet?.favoriteCount! += 1
            
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    
                    let image = UIImage(named: "favor-icon-red")
                    self.favoriteButton.setImage(image, for: UIControlState.normal)
                }
            }
        }

    }
    
    
    @IBAction func didTapRetweet(_ sender: UIButton) {
        if(tweet?.retweeted)! {
            
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweetd the following Tweet: \n\(tweet.text)")
                    tweet.retweeted = false
                    
                    let image = UIImage(named: "retweet-icon")
                    self.retweetButton.setImage(image, for: UIControlState.normal)
                }
            }
        } else {
            
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweetd the following Tweet: \n\(tweet.text)")
                    tweet.retweeted = true
                    
                    let image = UIImage(named: "retweet-icon-green")
                    self.retweetButton.setImage(image, for: UIControlState.normal)
                }
            }
        }
        
    }
    @IBAction func didTapReply(_ sender: Any) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("boi i ran")
        //        if let composeViewController = segue.destination as? ComposeViewController {
        //            composeViewController.delegate = self
        //
        //        }
        
        if let replyViewController = segue.destination as? ReplyViewController {
            replyViewController.boi = "watican"
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    @IBAction func didTapCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
