//
//  CustomError.swift
//  ReticleV1
//
//  Created by Sagar Unagar on 15/04/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import Foundation
class CustomError: Error {
    
    open var domain: String = ""
    open var code: Int = 0
    open var localizedDescription: String = ""
    
    init(errorDomain domain:String,errorCode code:Int, localizedDescription description:String) {
        
        self.domain = domain
        self.code = code
        self.localizedDescription = description
    }
    
    
    convenience init(description:String) {
        
        self.init(errorDomain: "", errorCode: 0, localizedDescription:description)
    }
    
    convenience init(error: NSError) {
        
        self.init(errorDomain: error.domain, errorCode: error.code, localizedDescription:error.localizedDescription)
    }
    
    convenience init(error: Error) {
        
        self.init(errorDomain: "", errorCode: 0, localizedDescription:error.localizedDescription)
    }
    
}


