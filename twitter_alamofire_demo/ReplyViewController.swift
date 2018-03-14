//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Honorio Vega on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    var boi : String?
    var to: String?
    @IBOutlet weak var nameTextView: UITextField!
    
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.text = boi
        tweetTextView.text = "@\(to as! String)"
        let profilePicURL = User.current?.profileImageLink
        profileImageView.af_setImage(withURL: URL(string: profilePicURL!)!)
 
      
    }

    @IBAction func didTapClose(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
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
