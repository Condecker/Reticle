//
//  EditProfileViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class EditProfileViewController: UIViewController {
    
    var ref = Database.database().reference()
    var supervisorList = [SupervisorModel]()

    var username: String = "Condecker"
     var firstName: String = "Claudia"
     var lastName: String = "Ondecker"
     var email: String = "ClaudiaOndecker@icloud.com"
     var phoneNum: String = "9083409600"
     var badgeNum: String = "23432-234321"

    @IBOutlet weak var usernameBox: UITextField!
    
    @IBOutlet weak var firstNameBox: UITextField!
    @IBOutlet weak var lastNameBox: UITextField!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var phoneNumBox: UITextField!
    @IBOutlet weak var badgeNumBox: UITextField!
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
        firstNameBox.text = firstName
        usernameBox.text = username
        lastNameBox.text = lastName
        emailBox.text = email
        phoneNumBox.text = phoneNum
        badgeNumBox.text = badgeNum
}
    
    @IBAction func editClicked(_ sender: Any) {
        username = usernameBox.text!
        firstName = firstNameBox.text!
        lastName = lastNameBox.text!
        email = emailBox.text!
        phoneNum = phoneNumBox.text!
    }
    
    
    
}
