//
//  CardDetailViewController.swift
//  CallingApp
//
//  Created by Nikita Benin on 04/09/2018.
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var interestsLbl: UILabel!
    @IBOutlet weak var phoneNumLbl: UILabel!
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        userImage.image = UIImage(named: "detailImagePng")
        nameLbl.text = "Jyn Erso"
        ageLbl.text = "Age: 21"
        interestsLbl.text = "Interests: Dancing"
        phoneNumLbl.text = "Phone number: +0 000 000-00-00"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
