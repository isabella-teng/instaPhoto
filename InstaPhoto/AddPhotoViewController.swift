//
//  AddPhotoViewController.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/27/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

import UIKit
import Parse

//to do: put in ViewDidAppear, view did load only runs once, boolean if presented picture

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func takePhoto(_ sender: Any) {
        //instantiate a UIImagePickerController
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
        
        //set the source of the picture if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available!")
            vc.sourceType = .camera
        } else {
            print("Camera is not available so we will use the photo library instead")
            vc.sourceType = .photoLibrary
        }
        
    }

    @IBAction func uploadPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //resize image for Parse
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //this is the photo after you crop it
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        //do something with the images, resize for Parse here & then upload
        
        //send the image to the editing view controller
        self.performSegue(withIdentifier: "editingSegue", sender: nil)
        
        //dismiss UIImageController to go back to original view controller
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
