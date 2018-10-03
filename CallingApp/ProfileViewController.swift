//
//  ProfileViewController.swift
//  CallingApp
//
//  Created by Nikita Benin on 14/09/2018.
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ProfileViewController: UIViewController {

    //info to save
    var contactDictArray = [[String: String]]()
    var interestsArray = [String]()
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    //
    
    @IBOutlet weak var interestOne: UITextField!
    @IBOutlet weak var interestTwo: UITextField!
    @IBOutlet weak var interestThree: UITextField!
    
    
    @IBOutlet weak var contactsTable: UITableView!
    
    @IBAction func showContactsApp(_ sender: UIButton) {
        saveData()
        let alert = UIAlertController(title: "Choose number from iOS contacts or cards", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "From contacts", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.getContact()
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        alert.addAction(UIAlertAction(title: "From cards", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                let next:KolodaViewController = self.storyboard?.instantiateViewController(withIdentifier: "cardScreen") as! KolodaViewController
                self.navigationController?.pushViewController(next, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
            
        self.present(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData()
        
        if interestsArray.count > 0 {
            interestOne.text = interestsArray[0]
            interestTwo.text = interestsArray[1]
            interestThree.text = interestsArray[2]
        }
        
        if interestOne.text != "" {
            interestOne.backgroundColor = UIColor.init(named: "facebook")
            interestOne.textColor = UIColor.white
        }
        if interestTwo.text != "" {
            interestTwo.backgroundColor = UIColor.init(named: "facebook")
            interestTwo.textColor = UIColor.white
        }
        if interestThree.text != "" {
            interestThree.backgroundColor = UIColor.init(named: "facebook")
            interestThree.textColor = UIColor.white
        }
        
        
//        contactDictArray.append(["givenName" : "Username", "familyName" : "", "phoneNum" : "000000000"])
        
        contactsTable.delegate = self
        contactsTable.dataSource = self
        
    }
    
    
    
    func saveData() {
        if interestsArray.count > 0 {
            interestsArray[0] = interestOne.text!
            interestsArray[1] = interestTwo.text!
            interestsArray[2] = interestThree.text!
        }else{
            interestsArray = ["","",""]
        }
        
        UserDefaults.standard.set(userName.text, forKey: "cUsername")
        UserDefaults.standard.set(userAge.text, forKey: "cAgename")
        UserDefaults.standard.set(contactDictArray, forKey: "cDictArray")
        UserDefaults.standard.set(interestsArray, forKey: "cInterestArray")
    }
    
    func retriveData(){
        
        userName.text = UserDefaults.standard.object(forKey: "cUsername") as? String
        userAge.text = UserDefaults.standard.object(forKey: "cAgename") as? String
        
        if UserDefaults.standard.object(forKey: "cDictArray") != nil{
            contactDictArray = UserDefaults.standard.object(forKey: "cDictArray") as! [[String : String]]
        }else{
            contactDictArray = [[String: String]]()
        }
        
        if UserDefaults.standard.object(forKey: "cInterestArray") != nil{
            interestsArray = UserDefaults.standard.object(forKey: "cInterestArray") as! [String]
        }else{
            interestsArray = ["","",""]
        }
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        saveData()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- CNContactPickerDelegate Method
    
    func getContact() {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }

}
extension ProfileViewController: CNContactPickerDelegate {
    
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            let phoneNumberCount = contact.phoneNumbers.count
            
            guard phoneNumberCount > 0 else {
                dismiss(animated: true)
                //show pop up: "Selected contact does not have a number"
                return
            }
            print("Contact name is:", contact.givenName, contact.familyName)
            self.contactDictArray.append(["givenName" : contact.givenName, "familyName" : contact.familyName])
            if phoneNumberCount == 1 {

                
                setNumberFromContact(contactNumber: contact.phoneNumbers[0].value.stringValue)
                
                
            } else {
                let alertController = UIAlertController(title: "Select one of the numbers", message: nil, preferredStyle: .actionSheet)
                
                for i in 0...phoneNumberCount-1 {
                    let phoneAction = UIAlertAction(title: contact.phoneNumbers[i].value.stringValue, style: .default, handler: {
                        alert -> Void in
                        self.setNumberFromContact(contactNumber: contact.phoneNumbers[i].value.stringValue)
                    })
                    alertController.addAction(phoneAction)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                    alert -> Void in
                    
                })
                alertController.addAction(cancelAction)
                
                dismiss(animated: true)
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        
        }
        
        func setNumberFromContact(contactNumber: String){
            
            //UPDATE YOUR NUMBER SELECTION LOGIC AND PERFORM ACTION WITH THE SELECTED NUMBER
            guard contactNumber.count >= 10 else {
                dismiss(animated: true) {
                    //self.popUpMessageError(value: 10, message: "Selected contact does not have a valid number")
                }
                return
            }
            
            print("Contact number is:", contactNumber)
            contactDictArray[contactDictArray.count - 1].updateValue(contactNumber, forKey: "phoneNum")
            print("Dict is:", contactDictArray)
            saveData()
            contactsTable.reloadData()
            
        }
        
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            
        }
    
}


extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if contactDictArray.count + 1 <= 5{
            return contactDictArray.count + 1
        }else{
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < contactDictArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
            let fullName = contactDictArray[indexPath.row]["givenName"]! + " " + contactDictArray[indexPath.row]["familyName"]!
            cell.lblContactName.text = fullName
            cell.lblContactNumber.text = contactDictArray[indexPath.row]["phoneNum"]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addContactCell", for: indexPath) as! AddContactCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath)
    }
}
extension ProfileViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField != userName && textField != userAge{
            textField.placeholder = nil
        }
        
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.placeholder = "+"
        }else{
            textField.backgroundColor = UIColor.init(named: "facebook")
            textField.textColor = UIColor.white
        }
        
        if userName.text == "" {
            userName.placeholder = "UserName"
        }else{
            userName.backgroundColor = UIColor.white
            userName.textColor = UIColor.black
        }
        if userAge.text == "" {
            userAge.placeholder = "UserAge"
        }else{
            userAge.backgroundColor = UIColor.white
            userAge.textColor = UIColor.black
        }
        
        saveData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
