//
//  ProfileViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/27/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//


//fix logout to just dismiss NOT what I have now??
import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var allPosts: [PFObject]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        //customize layout of the photo grid
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        //let screenHeight = screenSize.height

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        //setup a sticky header
//         tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        fetchPosts()
    }
    
    
    func fetchPosts() {
        let query = PFQuery(className: "Post")
        
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current())
        //author is a PFuser object
        
        
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.allPosts = posts
                self.collectionView.reloadData()
            }
            
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionPhotoCell", for: indexPath) as!
        CollectionPhotoCell
        
        let singlePost = allPosts?[indexPath.item]
        cell.instagramPost = singlePost
        
        return cell
    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in
            //PFUser.currentUser() will now be nil
            PFUser.logOut()
            print("User has logged out")
            NotificationCenter.default.post(name: NSNotification.Name("logoutNotification"), object: nil)
            
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        destinationViewController.post = allPosts?[indexPath!.row]
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
