//
//  SupervisorTableViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/4/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SupervisorTableViewController: UITableViewController {

    var ref = Database.database().reference()
    var supervisorList = [SupervisorModel]()
    
    override func viewDidLoad() {
        print(supervisorList.count)
        super.viewDidLoad()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ref = self.ref.child("users")

        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.supervisorList.removeAll()
                
                for supervisors in snapshot.children.allObjects as![DataSnapshot]{
                    let supervisorObject = supervisors.value as? [String: AnyObject]
                    let firstName = supervisorObject?["firstName"]
                    let uid = supervisorObject?["uid"]
                    let badgeNumber = supervisorObject?["badgeNumber"]
                    
                    let lastName = supervisorObject?["lastName"]
                    let phone = supervisorObject?["phone"]
                    let username = supervisorObject?["username"]
                    let email = supervisorObject?["email"]
                    
                    let supervisor = SupervisorModel(uid: uid as? String, badgeNumber: badgeNumber as? String, firstName: firstName as? String, lastName: lastName as? String, phone: phone as? String, username: username as? String, email: email as? String)
                    
                    self.supervisorList.append(supervisor)
                    print(badgeNumber)
                }
            self.tableView.reloadData()
            }
            
        })
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return supervisorList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supervisorCell", for: indexPath)

        // Configure the cell...
        let supervisor: SupervisorModel
        supervisor = supervisorList[indexPath.row]
 
        cell.textLabel?.text = ("Officer " + supervisor.firstName! + " " + supervisor.lastName!)
        cell.detailTextLabel?.text = ("Badge Number: " + supervisor.badgeNumber!)
        
        return cell
    }

}
