//
//  AddContactCell.swift
//  CallingApp
//
//  Created by Nikita Benin on 21/09/2018.
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

import UIKit

class AddContactCell: UITableViewCell {

    @IBOutlet weak var lblButton: UIButton!
    @IBOutlet weak var lblCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCell.text = "Add number"
        
//        let tap = UITapGestureRecognizer(target: self, action: nil)
//            tap.cancelsTouchesInView = false
//            self.view.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }
    
    

}
