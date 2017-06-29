//
//  CollectionPhotoCell.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/29/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class CollectionPhotoCell: UICollectionViewCell {
    

    
    @IBOutlet weak var picImageView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.picImageView.file = instagramPost["media"] as? PFFile
            self.picImageView.loadInBackground()
        }
    }
    
}
