//
//  OfficerModel.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import Foundation
import Firebase

class OfficerModel{
    var badgeNumberID: String?
    var badgeNumber: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var email: String?
    var bwc: String?
    
    init(badgeNumberID:String?, badgeNumber:String?, firstName:String?, lastName:String?, phone:String?, email:String?, bwc: String?){
        self.badgeNumberID = badgeNumberID
        self.badgeNumber = badgeNumber
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.bwc = bwc
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let badgeNumber = value["badgenum"] as? String,
            let email = value["email"] as? String,
            let firstName = value["firstname"] as? String,
            let lastName = value["lastName"] as? String,
            let phoneNumber = value["phone"] as? String,
            let bwc = value["bwcSerialNumber"] as? String else {
                return nil
        }
        
        self.badgeNumber = badgeNumber
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phoneNumber
        self.bwc = bwc
    }
}
