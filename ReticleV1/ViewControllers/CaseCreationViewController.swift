//
//  CaseCreationViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class CaseCreationViewController: UIViewController {

    @IBOutlet weak var caseNumBox: UITextField!
    @IBOutlet weak var dateBox: UITextField!
    @IBOutlet weak var officerBox: UITextField!
    @IBOutlet weak var officerEmailBox: UITextField!
    @IBOutlet weak var supervisorBox: UITextField!
    @IBOutlet weak var incidentTypeBox: UITextField!
    @IBOutlet weak var mediaBox: UITextField!
    @IBOutlet weak var streetAddressBox: UITextField!
    @IBOutlet weak var zipBox: UITextField!
    @IBOutlet weak var startBox: UITextField!
    @IBOutlet weak var bwcBox: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backupbtn: UIButton!
    @IBOutlet weak var causeBtn: UIButton!
    @IBOutlet weak var arrestBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var handcuffBtn: UIButton!
    @IBOutlet weak var seatbeltBtn: UIButton!

    @IBOutlet weak var backupSwitch: UISwitch!
    @IBOutlet weak var causeSwitch: UISwitch!
    @IBOutlet weak var reasonSwitch: UISwitch!
    @IBOutlet weak var searchSwitch: UISwitch!
    @IBOutlet weak var handcuffSwitch: UISwitch!
    @IBOutlet weak var beltSwitch: UISwitch!
    
    @IBOutlet weak var arrestSwitch: UISwitch!
    @IBOutlet weak var releaseSwitch: UISwitch!
    @IBOutlet weak var warningSwitch: UISwitch!
    @IBOutlet weak var hospitalSwitch: UISwitch!
    @IBOutlet weak var treatmentSwitch: UISwitch!
    @IBOutlet weak var prisonerSwitch: UISwitch!

    var ref: DatabaseReference!
    var officerNames = [String] ()
    var supervisorNames = [String] ()
    var officerEmails = [String] ()
    var officerBWCS = [String] ()
    var pickerData = [String] ()
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var enteredData  = [String: Any]()
    var pickerView3 = UIDatePicker()
    var pickerView4 = UIPickerView()
    var pickerView5 = UIPickerView()
    var pickerView6 = UIDatePicker()
    
    var years = [String]()
    var incidentTypes = ["Arrest", "Crash Investigation", "Criminal Incident Response", "Domestic Violence", "Medical Call", "Non-Criminal Citizen Contact", "Prisoner Transport", "Prisoner Hospital Security", "Suspicious Event", "Traffic Stop", "Use of Force", "Vehicle Pursuit"]
    var mediaTypes = ["BWC", "In House Video", "MVR", "None"]

    var backup: String = "2"
    var cause: String = "2"
    var reason: String = "2"
    var search: String = "2"
    var handcuff: String = "2"
    var belt: String = "2"
    
    var arrest: String = "2"
    var release: String = "2"
    var warning: String = "2"
    var hospital: String = "2"
    var treatment: String = "2"
    var prisoner: String = "2"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        //pickerview
        self.pickerView1.delegate = self
        self.pickerView2.delegate = self
        self.pickerView4.delegate = self
        self.pickerView5.delegate = self
        
        
        self.officerBox.inputView = self.pickerView1
        self.supervisorBox.inputView = self.pickerView2
        self.incidentTypeBox.inputView = self.pickerView4
        self.mediaBox.inputView = self.pickerView5
        
        self.addDoneOnKeyboard(textField: officerBox)
        self.addDoneOnKeyboard(textField: dateBox)
        self.addDoneOnKeyboard(textField: supervisorBox)
        self.addDoneOnKeyboard(textField: incidentTypeBox)
        self.addDoneOnKeyboard(textField: mediaBox)
        self.addDoneOnKeyboard(textField: startBox)
        
        //date picker
        for year in (2000...2020) {
            self.years.append(String(year))
        }
        self.configureDatePickerView()
        self.configureTimePickerView()
        self.dateBox.inputView = self.pickerView3
        self.startBox.inputView = self.pickerView6
        
        //firebase stuff
        self.fetchAllOfficersFromFirebase()
        self.fetchAllSupervisorsFromFirebase()
    }
    
    
    //switches
    @IBAction func backupSwitchClicked(_ sender: Any) {
        if (backupSwitch.isOn == true){
            print("its on")
            let backup = "1"
            print("the backup state is" + backup)
        }
        else {
            print("its off")
            let backup = "0"
            print("the backup state is" + backup)
        }
    }
    
    //methods
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
                    self.officerBWCS.append(officer.bwc!)
                }
            }
        }
    }
    
    func fetchAllSupervisorsFromFirebase() {
        NetworkServices.fetchSupervisors { (supervisors, error) in
            if error != nil {
                let errorObj = error as! CustomError
                self.showAlert(title: "Error!", message: errorObj.localizedDescription)
                return
            } else {
                let supervisorsFromFirebase = supervisors as! [SupervisorModel]
                for supervisor in supervisorsFromFirebase {
                    self.supervisorNames.append(supervisor.firstName! + " " + supervisor.lastName!)
                }
            }
        }
    }

    func configureDatePickerView() {
        self.pickerView3.datePickerMode = .date
        self.pickerView3.addTarget(self, action: #selector(dobValueChanged), for: .valueChanged)
        self.dateBox.inputView = self.pickerView3
    }
    
    func configureTimePickerView() {
        self.pickerView6.datePickerMode = .time
        self.pickerView6.addTarget(self, action: #selector(timeValueChanged), for: .valueChanged)
        self.startBox.inputView = self.pickerView6
    }
    
    @objc func dobValueChanged() {
        let selectedDate = self.pickerView3.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: selectedDate)
        self.dateBox.text = dateString
    }
    
    @objc func timeValueChanged(){
        let selectedTime = self.pickerView6.date
        self.pickerView6.datePickerMode = .time
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        startBox.text = formatter.string(from: selectedTime)
    }
    
    
    func addDoneOnKeyboard(textField: UITextField) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
    }
    
    func isValidInputs() -> Bool {
        if self.caseNumBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter case number.")
            return false
        } else if dateBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter case date.")
            return false
        }  else if officerBox.text == "" {
            self.showAlert(title: "Error", message: "Please select case officer.")
            return false
        }  else if supervisorBox.text == "" {
            self.showAlert(title: "Error", message: "Please select case supervisor.")
            return false
        }  else if officerEmailBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter officer email address.")
            return false
        }  else if incidentTypeBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter incident type.")
            return false
        }  else if mediaBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter media.")
            return false
        }  else if streetAddressBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter street address.")
            return false
        }  else if zipBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter zip code.")
            return false
        }  else if startBox.text == "" {
            self.showAlert(title: "Error", message: "Please select start time.")
            return false
        }  else if bwcBox.text == "" {
            self.showAlert(title: "Error", message: "Please enter BWC.")
            return false
        } else {
            return true
        }
    }
}

//buttons
extension CaseCreationViewController {
    @IBAction func nextClicked(_ sender: Any) {
        if self.isValidInputs() == true {
            let casenum = caseNumBox.text
            let date = dateBox.text
            let officer = officerBox.text
            let supervisor = supervisorBox.text
            let officeremail = officerEmailBox.text
            let incident = incidentTypeBox.text
            let media = mediaBox.text
            let address = streetAddressBox.text
            let zip = zipBox.text
            let time = startBox.text
            let bwc = bwcBox.text
            
            //backup
            let bu = backup
            var i = "100"
            if (backupSwitch.isOn == true){
                i = "1"
                print("the backup state is" + bu)
            } else {
                i = "0"
                print("the backup state is" + bu)
            }
            backup = i
            
            //cause
            let ca = cause
            var j = "100"
            if (causeSwitch.isOn == true){
                j = "1"
                print("the cause state is" + ca)
            } else {
                j = "0"
                print("the cause state is" + ca)
            }
            cause = j
            
            //reason
            let re = reason
            var k = "100"
            if (reasonSwitch.isOn == true){
                k = "1"
            } else {
                k = "0"
            }
            reason = k
            
            //search
            let se = search
            var l = "100"
            if (searchSwitch.isOn == true){
                l = "1"
            } else {
                l = "0"
            }
            search = l
            
            //handcuff
            let ha = handcuff
            var m = "100"
            if (handcuffSwitch.isOn == true){
                m = "1"
            } else {
                m = "0"
            }
            handcuff = m
            
            //belt
            let be = belt
            var n = "100"
            if (beltSwitch.isOn == true){
                n = "1"
            } else {
                n = "0"
            }
            belt = n
            
            //arrest
            let ar = arrest
            var o = "100"
            if (arrestSwitch.isOn == true){
                o = "1"
            } else {
                o = "0"
            }
            arrest = o
            
            //release
            let rel = release
            var p = "100"
            if (releaseSwitch.isOn == true){
                p = "1"
            } else {
                p = "0"
            }
            release = p
            
            //warning
            let wa = warning
            var q = "100"
            if (warningSwitch.isOn == true){
                q = "1"
            } else {
                q = "0"
            }
            warning = q
            
            //hosptial
            let ho = hospital
            var r = "100"
            if (hospitalSwitch.isOn == true){
                r = "1"
            } else {
                r = "0"
            }
            hospital = r
            
            //treatment
            let tr = treatment
            var s = "100"
            if (treatmentSwitch.isOn == true){
                s = "1"
            } else {
                s = "0"
            }
            treatment = s
            
            //prisoner
            let pr = prisoner
            var t = "100"
            if (prisonerSwitch.isOn == true){
                t = "1"
            } else {
                t = "0"
            }
            prisoner = t
            
            enteredData["caseNumber"] = casenum!
            enteredData["date"] = date!
            enteredData["officer"] = officer!
            enteredData["supervisor"] = supervisor!
            enteredData["officerEmail"] = officeremail!
            enteredData["incidentType"] = incident!
            enteredData["mediaType"] = media!
            enteredData["address"] = address!
            enteredData["zipCode"] = zip!
            enteredData["startTime"] = time!
            enteredData["bwcSerialNumber"] = bwc!
            print(backup)
            
            //add switches
            enteredData["backup"] = backup
            enteredData["probableCause"] = cause
            enteredData["reasonOfArrest"] = reason
            enteredData["searched"] = search
            enteredData["handcuffed"] = handcuff
            enteredData["seatbelt"] = belt
            enteredData["arrest"] = arrest
            enteredData["released"] = release
            enteredData["warning"] = warning
            enteredData["hospital"] = hospital
            enteredData["treatment"] = treatment
            enteredData["prisonerTransport"] = prisoner
        
            
            
            
            //enteredData["\(casenum!)"] = caseData
            
            self.performSegue(withIdentifier: "nextPage", sender: self)
        }
    }
    
    @objc func doneButtonPressed() {
        self.view.endEditing(true)
    }
}

//PickerView Delegate
extension CaseCreationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == pickerView1 {
            return 1
        } else if pickerView == pickerView2{
            return 1
        } else if pickerView == pickerView3 {
            return 1
        } else if pickerView == pickerView4{
            return 1
        } else if pickerView == pickerView5 {
            return 1
        } else if pickerView == pickerView6 {
            return 2
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
        return self.officerNames.count
        } else if pickerView == pickerView2 {
            return self.supervisorNames.count
        } else if pickerView == pickerView3 {
            return self.years.count
        } else if pickerView == pickerView4 {
            return self.incidentTypes.count
        } else if pickerView == pickerView5 {
            return self.mediaTypes.count
        } else if pickerView == pickerView6 {
            return 60
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
        return self.officerNames[row]
        } else if pickerView == pickerView2 {
            return self.supervisorNames[row]
        } else if pickerView == pickerView3 {
            return self.years[row]
        } else if pickerView == pickerView4 {
            return self.incidentTypes[row]
        } else if pickerView == pickerView5 {
            return self.mediaTypes[row]
        } else if pickerView == pickerView6 {
            return String(format: "%02d", row)
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       if pickerView == pickerView1 {
        self.officerBox.text = self.officerNames[row]
        self.officerEmailBox.text = self.officerEmails[row]
        self.bwcBox.text = self.officerBWCS[row]
        }
        else if pickerView == pickerView2 {
         self.supervisorBox.text = self.supervisorNames[row]
        }
        
       else if pickerView == pickerView3 {
            self.dateBox.text = self.years[row]
        }
        
       else if pickerView==pickerView4{
        self.incidentTypeBox.text = self.incidentTypes[row]
        }
        
       else if pickerView == pickerView5{
        self.mediaBox.text = self.mediaTypes[row]
        }
        
       else if pickerView == pickerView6 {
        if component == 0{
            let hour = row
            print("hour: \(hour)")
        }else{
            let minute = row
            print("minute: \(minute)")
        }
        }
    }
}






//text box Delegate Methods
extension CaseCreationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

//Segues
extension CaseCreationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextPage" {
            let destinationVC = segue.destination as! ReportsViewController
            destinationVC.enteredData = self.enteredData
        }
    }
}
