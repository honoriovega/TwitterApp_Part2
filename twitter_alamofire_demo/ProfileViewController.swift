//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Honorio Vega on 3/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingLabelCount: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let profilePictureURL = URL(string: (User.current?.profileImageLink)!)
        profilePicImageView.af_setImage(withURL: profilePictureURL!)
        
        followerCountLabel.text = "\(User.current?.followerCount as! Int)"
        
        followingLabelCount.text = "\(User.current?.followerCount as! Int)"
        
        tweetCountLabel.text = "\(User.current?.numOfTweets as! Int)"
        
        descriptionLabel.text = User.current?.description
        let backgroundURL = URL(string: (User.current?.profileBackgroundURL)!)
        backgroundImageView.af_setImage(withURL: backgroundURL!)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
