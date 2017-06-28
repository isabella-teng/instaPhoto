//
//  InstaPostTableViewCell.swift
//  Instaphoto
//
//  Created by Isabella Teng on 6/28/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstaPostTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var imgPostImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            self.imgPostImageView.file = instagramPost["media"] as? PFFile
            self.imgPostImageView.loadInBackground()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
