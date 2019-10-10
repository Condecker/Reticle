//
//  CaseDetailViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/26/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit

class DetailCaseViewController: UIViewController {
    
    var caseNumber: String?
    var caseType: String?

    var selectedDate: String?
    var selectedOfficer: String?
    var selectedSupervisor: String?
    var selectedOE: String?
    var selectedMedia: String?
    var selectedAddress: String?
    var selectedZip: String?
    var selectedTime: String?
    var selectedBWC: String?
    var selectedBackup: String?
    var selectedCause: String?
    var selectedReason: String?
    var selectedSearch: String?
    var selectedHandcuffs: String?
    var selectedBelt: String?
    var selectedArrest: String?
    var selectedReleased: String?
    var selectedWarning: String?
    var selectedhospital: String?
    var selectedTreatment: String?
    var selectedPrisoner: String?
    
    @IBOutlet weak var caseNum: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var officer: UITextField!
    @IBOutlet weak var supervisor: UITextField!
    @IBOutlet weak var officerEmail: UITextField!
    @IBOutlet weak var incidentType: UITextField!
    @IBOutlet weak var media: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var bwc: UITextField!
    
    @IBOutlet weak var backup: UISwitch!
    @IBOutlet weak var cause: UISwitch!
    @IBOutlet weak var reason: UISwitch!
    @IBOutlet weak var search: UISwitch!
    @IBOutlet weak var handcuffs: UISwitch!
    @IBOutlet weak var belt: UISwitch!
    @IBOutlet weak var arrest: UISwitch!
    @IBOutlet weak var released: UISwitch!
    @IBOutlet weak var warning: UISwitch!
    @IBOutlet weak var hospital: UISwitch!
    @IBOutlet weak var treatment: UISwitch!
    @IBOutlet weak var prisoner: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        caseNum.text = caseNumber
        incidentType.text = caseType
        date.text = selectedDate
        officer.text = selectedOfficer
        supervisor.text = selectedSupervisor
        officerEmail.text = selectedOE
        media.text = selectedMedia
        address.text = selectedAddress
        zip.text = selectedZip
        startTime.text = selectedTime
        bwc.text = selectedBWC
        
        if(selectedBackup == "1"){
            backup.setOn(true, animated: false)
        }
        
        if(selectedCause == "1"){
            cause.setOn(true, animated: false)
        }
        
        if(selectedReason == "1"){
            reason.setOn(true, animated: false)
        }
        
        if(selectedSearch == "1"){
            search.setOn(true, animated: false)
        }
        
        if(selectedHandcuffs == "1"){
            handcuffs.setOn(true, animated: false)
        }
        
        if(selectedBelt == "1"){
            belt.setOn(true, animated: false)
        }
        
        if(selectedArrest == "1"){
            arrest.setOn(true, animated: false)
        }
        
        if(selectedReleased == "1"){
            released.setOn(true, animated: false)
        }
        
        if(selectedWarning == "1"){
            warning.setOn(true, animated: false)
        }
        
        if(selectedhospital == "1"){
            hospital.setOn(true, animated: false)
        }
        
        if(selectedTreatment == "1"){
            treatment.setOn(true, animated: false)
        }
        
        if(selectedPrisoner == "1"){
            prisoner.setOn(true, animated: false)
        }
        // Do any additional setup after loading the view.
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
