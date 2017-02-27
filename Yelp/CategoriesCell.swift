//
//  CategoriesCell.swift
//  Yelp
//
//  Created by Nam Pham on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol CategoriesCellDelegate{
    @objc optional func onSwitchChangeValue(_ categoriesCell: CategoriesCell)
}

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var swChange: UISwitch!
    @IBOutlet weak var lblTitle: UILabel!
    
    weak var delegate: CategoriesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onSwitchChangeValue(_ sender: UISwitch) {
        delegate?.onSwitchChangeValue?(self)
    }

}
