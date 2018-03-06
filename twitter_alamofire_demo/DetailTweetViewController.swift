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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    @IBAction func didTapCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
