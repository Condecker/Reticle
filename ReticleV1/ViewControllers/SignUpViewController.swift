//
//  SignUpViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/4/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passwordBox: UITextField!
    @IBOutlet weak var profilePic: UIImageView!

    @IBOutlet weak var usernameBox: UITextField!
    @IBOutlet weak var firstNameBox: UITextField!
    @IBOutlet weak var lastNameBox: UITextField!
    @IBOutlet weak var phoneBox: UITextField!
    @IBOutlet weak var badgeBox: UITextField!
    
    @IBOutlet weak var repeatPassBox: UITextField!
    // var ref: DatabaseReference!
   var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    @IBAction func createClicked(_ sender: Any) {
       let username = usernameBox.text
        let firstname = firstNameBox.text
        let lastname = lastNameBox.text
        let phone = phoneBox.text
        let badgenum = badgeBox.text
        let email = emailBox.text
        
        if let email = emailBox.text, let pass = passwordBox.text {
            Auth.auth().createUser(withEmail: email, password: pass) { user, error in if error == nil && user != nil {
                print ("User created!")
                
                
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = firstname
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print("errorrrrrrr")
                        } else {
                            print("display name is good")
                        }
                    }
                }
              
                
                 guard let uid = Auth.auth().currentUser?.uid else { return }
                
                /*Upload the image to firebase
                guard let image = self.profilePic.image else { return }
                guard let username = self.usernameBox.text else { return }
                
                self.uploadImageToFirebase(image) { url in
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        //changeRequest?.displayName = username
                        
                        changeRequest?.photoURL =  URL(string: url!)
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(username: username, profileImageURL: URL(string: url!)!) { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                            }
                        }
                    } else {
                        // Error unable to upload profile image
                    }
                }
                */
                
                //working code to add username
                self.ref.child("users/\(uid)/username").setValue(username)
                 self.ref.child("users/\(uid)/firstName").setValue(firstname)
                self.ref.child("users/\(uid)/lastName").setValue(lastname)
                self.ref.child("users/\(uid)/phone").setValue(phone)
                self.ref.child("users/\(uid)/badgeNumber").setValue(badgenum)
              self.ref.child("users/\(uid)/email").setValue(email)
                
                
                
                
                //Dismiss view
                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
                
            else {
                let alertController = UIAlertController(title: "Error", message: "Error creating user. Make sure all fields are entered.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                print ("Error creating user.")
                }
        }
    }
    }
    
    
    
    @IBAction func changeClick(_ sender: Any) {
        //TODO: Add camera access too
            self.openGallery()
        }
    
    
    func openCamera()
    {
       //eventually do this
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
            
        else
        {
            self.showAlert(title: "Warning!", message: "You don't have permission to access gallery.")
        }
    }
    

    func uploadImageToFirebase(_ image:UIImage, completion: @escaping ((_ url:String?)->())){
       
        /*
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        let data = Data()
       let imageData = image.jpegData(compressionQuality: 0.75)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("errrror")
                return
            }
            let size = metadata.size
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
            }
        }
        
        
        
        //let pictureRef = storageRef.child("user/\(uid)")
        */
    }
    
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        /*
        print ("got to save profile")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        //self.ref.child("users/\(uid)/username").setValue(username)
        self.ref.child("user/\(uid)/photoURL").setValue(profileImageURL.absoluteString)
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
 */
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

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        let image = info[.originalImage] as! UIImage
        profilePic.image = image
        //updateClassifications(for: image)
    }
}
