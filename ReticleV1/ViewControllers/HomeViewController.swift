//
//  HomeViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/2/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class HomeViewController: UIViewController {
    @IBOutlet weak var firstNameText: UILabel!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        firstNameText.text = (Auth.auth().currentUser?.email)! + "!"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
