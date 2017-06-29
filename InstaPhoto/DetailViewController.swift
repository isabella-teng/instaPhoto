//
//  DetailViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/28/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    
    var post: PFObject!
    
   
    @IBOutlet weak var picImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let author = post["author"] as? PFUser {
            let username = author.username
            usernameLabel.text = username
        }
        
        captionLabel.text = post["caption"] as! String
        
        picImageView.file = post["media"] as? PFFile
        picImageView.loadInBackground()

        
        if let time = post?.createdAt{
            //type cast from date to text
            
            let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
            let dateString = dateFormatter.string(from: time as Date)
            
            
            print(time)
            
            timeLabel.text = "Time Created: " + dateString
        }
        
    
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        print("back")
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
