//
//  LoginViewController.swift
//  CallApp
//
//  Created by Nikita Benin on 09/08/2018.
//  Copyright © 2018 Nikita Benin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let loginTypes = ["  Login with Facebook","  Login with Google","", "     Create Account"]
    let socialLogos = [#imageLiteral(resourceName: "facebook-logo"), #imageLiteral(resourceName: "google-logo"), UIImage.init(), UIImage.init()]
    let socialColors = [UIColor.init(named: "facebook"),UIColor.init(named: "google"), UIColor.clear, UIColor.clear]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension LoginViewController: UICollectionViewDelegate {
    
}

extension LoginViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginCell", for: indexPath) as! LoginTypeCell
        cell.layer.cornerRadius = 20
        
        if indexPath.row == 3 {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.white.cgColor
        }
        
        cell.socialLbl.text = loginTypes[indexPath.row]
        cell.socialImg.image = socialLogos[indexPath.row]
        cell.backgroundColor = socialColors[indexPath.row]
        return cell
    }
    
   
    
    
}
