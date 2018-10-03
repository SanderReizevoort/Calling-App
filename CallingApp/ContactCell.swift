//
//  ContactCell.swift
//  CallingApp
//
//  Created by Nikita Benin on 21/09/2018.
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!
    @IBAction func callNumber(_ sender: Any) {
        var contactNumber = lblContactNumber.text!
        contactNumber = contactNumber.replacingOccurrences(of: "+", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: "-", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: "(", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: ")", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: " ", with: "")
        guard let number = URL(string: "tel://" + contactNumber) else { return }
        UIApplication.shared.open(number)
        print("Calling number ", contactNumber)
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
