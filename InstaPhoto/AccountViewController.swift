//
//  AccountViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/27/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

//TO DO: get new post to automatically upload!

import UIKit
import Parse
import ParseUI

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var allPosts: [PFObject]? = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 600
        
        
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AccountViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    
    func fetchPosts() {
        let query = PFQuery(className: "Post")
        
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        
        
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
        
        //add if statement to only get the user id
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.allPosts = posts
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allPosts!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaPostTableViewCell", for: indexPath) as! InstaPostTableViewCell
        
        cell.contentView.frame = CGRect(x: 2, y: 2, width: 2, height: 2)
        
        let singlePost = allPosts![indexPath.row]
        
        if let author = singlePost["author"] as? PFUser {
            let username = author.username
            cell.usernameLabel.text = username
        }
        
        cell.captionLabel.text = singlePost["caption"] as! String
        cell.instagramPost = singlePost
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        destinationViewController.post = allPosts?[indexPath!.row]
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
