//
//  EditPhotoViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/27/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.

//TO DO: fix keyboard tap
//TO DO: fix segues and navigation

import UIKit
import Parse

class EditPhotoViewController: UIViewController {
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    

    @IBAction func onKeyTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    var chosenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = chosenImage
        
    }
    
    @IBAction func onPost(_ sender: Any) {
        Post.postUserImage(image: chosenImage, withCaption: captionTextView.text) { (success: Bool, error: Error?) in
            if success {
                print("Yay posted")
                //segue to the photo feed (Home) view controller
                self.performSegue(withIdentifier: "postSegue", sender: Any?.self)
                //self.tabBarController?.selectedIndex = 0
                
            } else {
                print(error?.localizedDescription)
            }
            
        }
        
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
