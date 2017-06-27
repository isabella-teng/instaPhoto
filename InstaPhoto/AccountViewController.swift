//
//  AccountViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/27/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

//TO DO: Add logout button

import UIKit
import Parse

class AccountViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            //PFUser.currentUser() will now be nil
            print("User has logged out")
            self.performSegue(withIdentifier: "logoutSegue", sender: nil )

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
