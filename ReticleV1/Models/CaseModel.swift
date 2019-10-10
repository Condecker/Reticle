//
//  CaseModel.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import Foundation
class CaseModel{
    var caseNumber: String?
    var date: String?
    var officer: String?
    var supervisor: String?
    var email: String?
    var type: String?
    var media: String?
    var address: String?
    var zip: String?
    var time: String?
    var bwc: String?
    var backup: String?
    var cause: String?
    var reason: String?
    var search: String?
     var handcuff: String?
     var belt: String?
     var arrest: String?
     var release: String?
     var warning: String?
     var hospital: String?
     var treatment: String?
     var prisoner: String?
    
    init(caseNumber:String?, date:String?, officer:String?, supervisor:String?, email:String?, type:String?, media:String?,address:String?,zip:String?,time:String?,bwc:String?, backup: String?, cause: String?, reason: String?, search: String?, handcuff: String?, belt: String?, arrest: String?, release: String?, warning: String?, hospital: String?, treatment: String?, prisoner: String?){
        self.caseNumber = caseNumber
        self.date = date
        self.officer = officer
        self.supervisor = supervisor
        self.email = email
        self.type = type
        self.media = media
        self.address = address
        self.zip = zip
        self.time = time
        self.bwc = bwc
        self.backup = backup
        self.cause = cause
        self.reason = reason
        self.search = search
        self.handcuff = handcuff
        self.belt = belt
        self.arrest = arrest
        self.release = release
        self.warning = warning
        self.hospital = hospital
        self.treatment = treatment
        self.prisoner = prisoner
    }
    
    
}
