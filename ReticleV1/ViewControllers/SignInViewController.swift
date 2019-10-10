//
//  SignInViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/2/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextBox.text!, password: passwordTextBox.text!) { (user, error) in
            if error == nil{
                print("sign in worked")
                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
            else{
                print ("sign in failed")
                let alertController = UIAlertController(title: "Error", message: "Username or password incorrect", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}
