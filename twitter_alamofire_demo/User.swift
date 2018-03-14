//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    // MARK: Properties
    var name: String
    var screenName: String?
    var profileImageLink: String?
    var description: String?
    var id: Int?
    var followerCount : Int
    var friends_count: Int
    var numOfTweets: Int
    var profileBackgroundURL : String?

//    "statuses_count": 3121,

    
    // Add any additional properties here

    //static var current: User?
    private static var _current: User?
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    // For user persistance
    var dictionary: [String: Any]?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
     

        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as? String
        profileImageLink = dictionary["profile_image_url_https"] as? String
        description = dictionary["description"] as? String
        id = dictionary["id"] as! Int
        description = dictionary["description"] as! String
        // Initialize any other properties
        followerCount  = dictionary["following"] as! Int
        friends_count = dictionary["followers_count"] as! Int
        numOfTweets = dictionary["statuses_count"] as! Int
        profileBackgroundURL = dictionary["profile_background_image_url_https"] as? String
    }
}
