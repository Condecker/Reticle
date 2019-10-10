//
//  ReportsViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/4/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ReportsViewController: UIViewController {

    @IBOutlet weak var caseNumPresent: UILabel!
    @IBOutlet weak var datePresent: UILabel!
    @IBOutlet weak var officerPresent: UILabel!
    @IBOutlet weak var supervisorPresent: UILabel!
    @IBOutlet weak var incidentPresent: UILabel!
    @IBOutlet weak var mediaPresent: UILabel!
    @IBOutlet weak var addressPresent: UILabel!
    @IBOutlet weak var zipPresent: UILabel!
    @IBOutlet weak var startPresent: UILabel!
    @IBOutlet weak var bwcPresent: UILabel!
    @IBOutlet weak var performancePresent: UILabel!
    @IBOutlet weak var dispositionPresent: UILabel!
    @IBOutlet weak var actionPresent: UILabel!
    @IBOutlet weak var caseNumBox: UITextField!
    
    
    @IBOutlet weak var officerEmailPresent: UILabel!
    @IBOutlet weak var counselingSwitch: UISwitch!
    @IBOutlet weak var trainingSwitch: UISwitch!
    @IBOutlet weak var rollCallSwitch: UISwitch!
    @IBOutlet weak var commSwitch: UISwitch!
    @IBOutlet weak var IASwitch: UISwitch!
    
    @IBOutlet weak var officerSwitch: UISwitch!
    @IBOutlet weak var supervisorSwitch: UISwitch!

    var ref = Database.database().reference()
    var reportsList = [CaseModel]()
    var enteredData = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayData()
       
    }
    
    func displayData() {
        self.caseNumPresent.text = " Case Number: \(enteredData["caseNumber"] as! String)"
        self.datePresent.text = " Date: \(enteredData["date"] as! String)"
        //print(enteredData["date"] as! String)
        self.officerPresent.text = " Officer: \(enteredData["officer"] as! String)"
        self.supervisorPresent.text = " Supervisor: \(enteredData["supervisor"] as! String)"
        self.incidentPresent.text = " Incident Type: \(enteredData["incidentType"] as! String)"
        self.mediaPresent.text = " Media Type: \(enteredData["mediaType"] as! String)"
        self.addressPresent.text = " Address: \(enteredData["address"] as! String)"
        self.zipPresent.text = " Zip Code: \(enteredData["zipCode"] as! String)"
        self.startPresent.text = " Start Time: \(enteredData["startTime"] as! String)"
        self.bwcPresent.text = " BWC Serial Number: \(enteredData["bwcSerialNumber"] as! String)"
        
        self.officerEmailPresent.text = enteredData["officerEmail"] as! String
        //self.performancePresent.text = enteredData["backup"] as! String
        //self.dispositionPresent.text = enteredData["date"] as! String
    }
    
   
    
    
    
    @IBAction func sendEmailClicked(_ sender: Any) {
        
        let officerEmail:String = enteredData["officerEmail"] as! String
        print(officerEmail)
        
        
        
        let mail = self.configMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mail, animated: true, completion: nil  )
        }
        else {
            self.sendMailError()
        }
        
        var caseData = [String: [String: Any]]()
        caseData["\(self.enteredData["caseNumber"]!)"] = self.enteredData
        NetworkServices.createcase(data: caseData) { (isAdded, error) in
            if error != nil {
                let errorObj = error as! CustomError
                self.showAlert(title: "Error!", message: errorObj.localizedDescription)
                return
            } else {
                if isAdded == true {
                    self.performSegue(withIdentifier: "goToCases", sender: self)
                    self.showAlert(title: "Case Added!", message: "Case # " + self.caseNumPresent.text! + " has been added.")
                } else {
                    self.showAlert(title: "Error!", message: "Something went wrong, Please try again!")
                }
            }
        }
        
    }
    

 
    
    func configMailController() -> MFMailComposeViewController{
       
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.setSubject("Information Regarding Case #" + (enteredData["caseNumber"] as! String))
        
        if (counselingSwitch.isOn == true){
            officerSwitch.setOn(true, animated: true)
        mailComposerVC.setMessageBody("<b>Case #\(enteredData["caseNumber"] as! String)</b> <p>On \(Date.getCurrentDate()), I reviewed case #\(enteredData["caseNumber"] as! String). You were conducting a(n) \(enteredData["incidentType"] as! String) on \(enteredData["date"] as! String) at \(enteredData["startTime"] as! String). During the \(enteredData["incidentType"] as! String) you failed to properly handle the situation. This letter is to inform you that your actions were inconsistent with our force's standards. Please review this case, as we believe you can learn from your mistakes for the future.</p><p></p><p>Should you require additional training in order to adequately perform this job function, please see \(enteredData["supervisor"] as! String) for additional instructions.</p><p>If you have any questions regarding my review, please feel free to contact me. A copy of this statement will remain on file.</p><p></p><p>CURRENTSUPERBISOR</p>", isHTML: true)
        }
        
        if (trainingSwitch.isOn == true){
            officerSwitch.setOn(true, animated: true)
            supervisorSwitch.setOn(true, animated: true)
        mailComposerVC.setMessageBody("<b>Case #\(enteredData["caseNumber"] as! String)</b><p>On \(Date.getCurrentDate()), I reviewed case #\(enteredData["caseNumber"] as! String). You were conducting a(n) \(enteredData["incidentType"] as! String) on \(enteredData["date"] as! String) at \(enteredData["startTime"] as! String). During the \(enteredData["incidentType"] as! String) you failed to properly handle the situation.</p><p>This letter is to inform you that your actions were inconsistent with our force's standards. Please review this case, as we believe you can learn from your mistakes for the future.</p><p> Notice will be made to \(enteredData["supervisor"] as! String) requesting additional training on your behalf in order to ensure you adequately perform this job function.</p><p>If you have any questions regarding my review, please feel free to reach out to me.<p></p> <p>CURRENT SUPERVISOR</p>", isHTML: true)
        }
        
        if (commSwitch.isOn == true){
            officerSwitch.setOn(true, animated: true)
            mailComposerVC.setMessageBody("<b>Case #\(enteredData["caseNumber"] as! String)</b><p>On \(Date.getCurrentDate()), I reviewed your case, #\(enteredData["caseNumber"] as! String). You were conducting a(n) \(enteredData["incidentType"] as! String)) on \(enteredData["date"] as! String) at \(enteredData["startTime"] as! String). During the \(enteredData["incidentType"] as! String) I believe you excelled during your duty.</p><p>This letter is to commend you on your actions, and inform you that notifcation will be made to the Awards Committee in consideration of your exemplary conduct.</p> <p>If you have any questions regarding my review, please feel free to contact me. A copy of this commendation will remain on file.</p> <p>We thank you for your good work.</p><p>CURRENT SUPERVISOR</p>", isHTML: true)
        }
        
        
        
        
        mailComposerVC.setCcRecipients(["reticlesolutions2019@gmail.com"])

        if(officerSwitch.isOn && supervisorSwitch.isOn){
            mailComposerVC.setToRecipients([officerEmailPresent.text!, "condecker@gmail.com"])
            mailComposerVC.mailComposeDelegate = self
        }
        
        else if (officerSwitch.isOn){
            mailComposerVC.setToRecipients([officerEmailPresent.text!])
            mailComposerVC.mailComposeDelegate = self
        }
        
        else if(supervisorSwitch.isOn){
            mailComposerVC.setToRecipients(["condecker@gmail.com"])
            mailComposerVC.mailComposeDelegate = self
        }
        
        
        
        
        self.performSegue(withIdentifier: "goToCases", sender: self)
        return mailComposerVC
    }
    
    func sendMailError(){
        let sendMailAlert = UIAlertController(title: "Didn't send", message: "Your device cant send emails", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailAlert.addAction(dismiss)
        self.present(sendMailAlert, animated: true, completion: nil)
        self.performSegue(withIdentifier: "goToCases", sender: self)
        
    }

}

extension ReportsViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: Date())
    }
}

