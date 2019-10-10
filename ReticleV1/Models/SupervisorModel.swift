//
//  SupervisorModel.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/4/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import Foundation
import Firebase

class SupervisorModel{
    var uid: String?
    var badgeNumber: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var username: String?
    var email: String?
    
    init(uid:String?, badgeNumber:String?, firstName:String?, lastName:String?, phone:String?, username:String?, email:String?){
        self.uid = uid
        self.badgeNumber = badgeNumber
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.username = username
        self.email = email
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let badgeNumber = value["badgeNumber"] as? String,
            let email = value["email"] as? String,
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let username = value["username"] as? String,
            let phoneNumber = value["phone"] as? String else {
                return nil
        }
        
        self.badgeNumber = badgeNumber
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phoneNumber
        self.username = username
    }
}
