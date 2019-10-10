//
//  OfficerTableViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class OfficerTableViewController: UITableViewController {
   
    var selectedOfficer: String?
    var officerEmail: String?
    var officerBadge: String?
    var officerPhone: String?
    var officerBWC: String?

    var ref = Database.database().reference()
    var officerList = [OfficerModel]()

    var officerNames = [String] ()
    var officerBadges = [String] ()
    var officerEmails = [String] ()
    var officerPhones = [String] ()
    var officerBWCS = [String] ()
    
    
    override func viewDidLoad() {
        print(officerList.count)
        super.viewDidLoad()
        self.fetchAllOfficersFromFirebase()
        
        ref = self.ref.child("officers")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.officerList.removeAll()
                
                for officers in snapshot.children.allObjects as![DataSnapshot]{
                    let officerObject = officers.value as? [String: AnyObject]
                    print(officerObject)
                    
                    let badgeNumberID = officerObject?["badgenum"]
                    let firstName = officerObject?["firstname"]
                    let badgeNumber = officerObject?["badgenum"]
                    
                    let lastName = officerObject?["lastName"]
                    let phone = officerObject?["phone"]
                  
                    let email = officerObject?["email"]
                    let bwc = officerObject?["bwcSerialNumber"]
                    
                    let officer = OfficerModel(badgeNumberID: badgeNumberID as? String, badgeNumber: badgeNumber as? String, firstName: firstName as? String, lastName: lastName as? String, phone: phone as? String, email: email as? String, bwc: bwc as? String)
                    
                    self.officerList.append(officer)
                    print(officer)
                    print(badgeNumber)
                }
                
                self.tableView.reloadData()
            }
            
        })

    }
    
    func fetchAllOfficersFromFirebase() {
        NetworkServices.fetchOfficers { (officers, error) in
            if error != nil {
                let errorObj = error as! CustomError
                self.showAlert(title: "Error!", message: errorObj.localizedDescription)
                return
            } else {
                let officersFromFirebase = officers as! [OfficerModel]
                for officer in officersFromFirebase {
                    self.officerNames.append(officer.firstName! + " " + officer.lastName!)
                    self.officerEmails.append(officer.email!)
                    self.officerBadges.append(officer.badgeNumber!)
                    self.officerPhones.append(officer.phone!)
                    self.officerBWCS.append(officer.bwc!)
                }
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return officerList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "officerCell", for: indexPath)

        // Configure the cell...
        let officer: OfficerModel
        officer = officerList[indexPath.row]
        
        cell.textLabel?.text = ("Officer " + officer.firstName! + " " + officer.lastName!)
     cell.detailTextLabel?.text = ("Badge Number: " + officer.badgeNumber!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        self.selectedOfficer = officerNames[indexPath.row]
        self.officerEmail = officerEmails[indexPath.row]
        self.officerBadge = officerBadges[indexPath.row]
        self.officerPhone = officerPhones[indexPath.row]
        self.officerBWC = officerBWCS[indexPath.row]
        print(officerNames[indexPath.row])
        print(officerEmails[indexPath.row])
        self.performSegue(withIdentifier: "OfficerToDetail", sender: self)
    }
    
}

extension OfficerTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OfficerToDetail" {
            let officerListVC = segue.destination as! OfficerViewController
            officerListVC.selectedOfficer = self.selectedOfficer
            officerListVC.officerEmail = self.officerEmail
            officerListVC.officerBadge = self.officerBadge
            officerListVC.officerPhone = self.officerPhone
            officerListVC.officerBWC = self.officerBWC
            print(self.selectedOfficer)
        }
}
}

