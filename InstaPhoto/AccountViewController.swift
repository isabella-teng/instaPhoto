//
//  AccountViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/27/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

//TO DO: Add refresh

import UIKit
import Parse
import ParseUI

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var allPosts: [PFObject]? = []
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPosts()
    }
    
    func fetchPosts() {
        var query = PFQuery(className: "Post")
        
        query.includeKey("author")
        
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
        
//        query.includeKey("user")
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.allPosts = posts
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaPostTableViewCell", for: indexPath) as! InstaPostTableViewCell
        let singlePost = allPosts![indexPath.row]
        
        let author = singlePost["author"] as! PFUser
        let username = author.username
        cell.usernameLabel.text = username
        cell.captionLabel.text = singlePost["caption"] as! String
//        let image = singlePost["media"] as! Data
//        cell.imgPostImageView.image = singlePost["media"] as! UIImage
//        cell.imgPostImageView.image = 
        
        cell.instagramPost = singlePost
        
        return cell
        
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
