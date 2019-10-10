//
//  NetworkServices.swift
//  ReticleV1
//
//  Created by Sagar Unagar on 15/04/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import Foundation
import Firebase

class NetworkServices {
    static func fetchOfficers (completion: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        let officerRef =  Database.database().reference(withPath: "officers")
        officerRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value != nil {
                var officers = [OfficerModel]()
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        let officer = OfficerModel(snapshot: snapshot)
                        officers.append(officer!)
                    }
                }
                completion(officers, nil)
                
            } else {
                let error = CustomError(description: "Not valid data!")
                completion(nil, error)
            }
        }
    }
    
    static func fetchSupervisors (completion: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        let supervisorRef =  Database.database().reference(withPath: "users")
        supervisorRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value != nil {
                var supervisors = [SupervisorModel]()
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        let supervisor = SupervisorModel(snapshot: snapshot)
                        supervisors.append(supervisor!)
                    }
                }
                completion(supervisors, nil)
                
            } else {
                let error = CustomError(description: "Not valid data!")
                completion(nil, error)
            }
        }
    }
    
    static func createcase (data: [String: Any], completion: @escaping (_ response: Bool?, _ error: Error?) -> Void) {
        let caseRef =  Database.database().reference(withPath: "cases")
        caseRef.updateChildValues(data) { (error, ref) in
            if error != nil {
                let errorObj = CustomError(error: error!)
                completion(false, errorObj)
            } else {
                completion(true, nil)
            }
        }
    }
    
}
