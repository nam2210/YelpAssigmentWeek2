//
//  OfferingCell.swift
//  Yelp
//
//  Created by Nam Pham on 2/25/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol OfferingCellDelegate {
    @objc optional func switchChanged(_ switchCell: OfferingCell)
}

class OfferingCell: UITableViewCell {

    @IBOutlet weak var swOffering: UISwitch!
    
    weak var delegate: OfferingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitchChange(_ sender: UISwitch) {
        delegate?.switchChanged?(self)
    }
}
