//
//  DetailViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/28/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//
//T0 Do: Fix crashes, fix pod

import UIKit
import Parse
import ParseUI
//import ChameleonFramework

class DetailViewController: UIViewController {

    
    var post: PFObject!
    
   
    @IBOutlet weak var picImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.sizeToFit()
        captionLabel.sizeToFit()
        timeLabel.sizeToFit()
        
//        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle, withFrame:CGRect, andColors:[UIColor.black, UIColor.white])
        
        if let author = post["author"] as? PFUser {
            let username = author.username
            usernameLabel.text = username
        }
        
        if let cap = post["caption"] as?  String {
            captionLabel.text = cap
        }
        
        
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
    

}
