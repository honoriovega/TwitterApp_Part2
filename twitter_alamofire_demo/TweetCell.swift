//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var usernameTextLabel: UILabel!
    @IBOutlet weak var timeStampTextLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    var tweet: Tweet! {
        didSet {
            //myButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal)

            if(tweet.favorited!) {
                let image = UIImage(named: "favor-icon-red")
                favoriteButton.setImage(image, for: UIControlState.normal)
            }
            
            if(tweet.retweeted) {
                let image = UIImage(named: "retweet-icon-green")
                self.retweetButton.setImage(image, for: UIControlState.normal)
            }
            tweetTextLabel.text = tweet.text
            nameTextLabel.text = tweet.user.name
            let username = tweet.user.screenName as! String
            usernameTextLabel.text = "@\(username)"
            if let stringURL = tweet.user.profileImageLink {
                let url = URL(string: stringURL)
                
                profilePictureImageView.af_setImage(withURL: url!)

            }
            
            timeStampTextLabel.text = tweet.createdAtString
        }
    }
    
    
    @IBAction func didTapFavorite(_ sender: Any) {
        
        // if it's favorited
        if(tweet.favorited!) {
            
            tweet.favorited = false
            if(tweet.favoriteCount! != 0 ) {
                tweet.favoriteCount! -= 1

            }

            // then unfavorite it
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorite the following Tweet: \n\(tweet.text)")
                    
                    let image = UIImage(named: "favor-icon")
                    self.favoriteButton.setImage(image, for: UIControlState.normal)
                }
            }
            
        } else {
            tweet.favorited = true
            
            tweet.favoriteCount! += 1
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
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
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
       
        if(tweet.retweeted) {

            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
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

            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
