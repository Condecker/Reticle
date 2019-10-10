//
//  AddOfficerViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class AddOfficerViewController: UIViewController {
    
     @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var firstNameBox: UITextField!
    @IBOutlet weak var lastNameBox: UITextField!
   
    @IBOutlet weak var phoneNumBox: UITextField!
    @IBOutlet weak var badgeNumBox: UITextField!
    
    @IBOutlet weak var addOfficerBtn: UIButton!
    
    @IBOutlet weak var BWCBox: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func addOfficerClicked(_ sender: Any) {
        let firstname = firstNameBox.text
        let lastname = lastNameBox.text
        let phone = phoneNumBox.text
        let badgenum = badgeNumBox.text
        let email = emailBox.text
        let badgeNumberID = badgeNumBox.text
        let BWC = BWCBox.text
        self.ref.child("officers/\(badgeNumberID!)/firstname").setValue(firstname)
        self.ref.child("officers/\(badgeNumberID!)/lastName").setValue(lastname)
        self.ref.child("officers/\(badgeNumberID!)/phone").setValue(phone)
        self.ref.child("officers/\(badgeNumberID!)/badgenum").setValue(badgenum)
                self.ref.child("officers/\(badgeNumberID!)/email").setValue(email)
             self.ref.child("officers/\(badgeNumberID!)/bwcSerialNumber").setValue(BWC)
        
        self.performSegue(withIdentifier: "goToOfficers", sender: self)
        self.showAlert(title: "Officer Added!", message: firstname! + " " + lastname! + " has been added to the database.")
    }
}
