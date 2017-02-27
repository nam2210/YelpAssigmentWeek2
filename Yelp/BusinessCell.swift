//
//  BusinessCell.swift
//  Yelp
//
//  Created by Nam Pham on 2/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var addrress: UILabel!
    @IBOutlet weak var category: UILabel!
    
    var business: Business!{
        didSet {
            //code
            businessImage.setImageWith(business.imageURL!)
            businessLabel.text = business.name
            distanceLabel.text = business.distance
            reviewImage.setImageWith(business.ratingImageURL!)
            //reviewCount.text = business.reviewCount as? String
            addrress.text = business.address
            category.text = business.categories
            
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
