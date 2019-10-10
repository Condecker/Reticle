//
//  caseListTableViewController.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/8/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class CaseListTableViewController: UITableViewController {
    
    var selectedCase: String?
    var selectedCaseType: String?
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
    
    var ref = Database.database().reference()
    var reportsList = [CaseModel]()
    
    var caseNums = [String] ()
    var caseTypes = [String] ()
    var caseDates = [String] ()
    var caseOfficers = [String] ()
    var caseSupers = [String] ()
    var caseOEs = [String] ()
    var caseMedias = [String] ()
    var caseAddresses = [String] ()
    var caseZips = [String] ()
    var caseStarts = [String] ()
    var caseBWCS = [String] ()
    var caseBackups = [String] ()
    var caseCauses = [String] ()
    var caseReasons = [String] ()
    var caseSearchs = [String] ()
    var caseHandcuffs = [String] ()
    var caseBelts = [String] ()
    var caseArrests = [String] ()
    var caseRels = [String] ()
    var caseWarnings = [String] ()
    var caseHospitals = [String] ()
    var caseTreatments = [String] ()
    var casePrisoners = [String] ()
    
    override func viewDidLoad() {
        print(reportsList.count)
        super.viewDidLoad()
        
        ref = self.ref.child("cases")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.reportsList.removeAll()
                
                for reports in snapshot.children.allObjects as![DataSnapshot]{
                    let reportsObject = reports.value as? [String: AnyObject]
                    print(reportsObject)
                    
                   
                    let address = reportsObject?["address"]
                    let bwcSerialNumber = reportsObject?["bwcSerialNumber"]
                    let caseNumber = reportsObject?["caseNumber"]
                    let date = reportsObject?["date"]
                    let incidentType = reportsObject?["incidentType"]
                    let mediaType = reportsObject?["mediaType"]
                    let officer = reportsObject?["officer"]
                    let officerEmail = reportsObject?["officerEmail"]
                    let startTime = reportsObject?["startTime"]
                    let supervisor = reportsObject?["supervisor"]
                    let zipCode = reportsObject?["zipCode"]
                    let bu = reportsObject?["backup"]
                    let ca = reportsObject?["probableCause"]
                    let re = reportsObject?["reasonOfArrest"]
                    let se = reportsObject?["searched"]
                    let ha = reportsObject?["handcuffed"]
                    let be = reportsObject?["seatbelt"]
                    let ar = reportsObject?["arrest"]
                    let rel = reportsObject?["released"]
                    let wa = reportsObject?["warning"]
                    let ho = reportsObject?["hospital"]
                    let tr = reportsObject?["treatment"]
                    let pr = reportsObject?["prisonerTransport"]
                    
                 
                    let reports = CaseModel(caseNumber: caseNumber as? String, date: date as? String, officer: officer as? String, supervisor: supervisor as? String, email: officerEmail as? String, type: incidentType as? String, media: mediaType as? String, address: address as? String, zip: zipCode as? String, time: startTime as? String, bwc: bwcSerialNumber as? String, backup: bu as? String, cause: ca as? String, reason: re as? String, search: se as? String, handcuff: ha as? String, belt: be as? String, arrest: ar as? String, release: rel as? String, warning: wa as? String, hospital: ho as? String, treatment: tr as? String, prisoner: pr as? String)
                    
                   
                    self.reportsList.append(reports)
                    self.caseNums.append(reports.caseNumber!)
                    self.caseTypes.append(reports.type!)
                    self.caseDates.append(reports.date!)
                    self.caseOfficers.append(reports.officer!)
                    self.caseSupers.append(reports.supervisor!)
                     self.caseOEs.append(reports.email!)
                     self.caseMedias.append(reports.media!)
                     self.caseAddresses.append(reports.address!)
                     self.caseZips.append(reports.zip!)
                     self.caseStarts.append(reports.time!)
                     self.caseBWCS.append(reports.bwc!)
                     self.caseBackups.append(reports.backup!)
                     self.caseCauses.append(reports.cause!)
                     self.caseReasons.append(reports.reason!)
                     self.caseHandcuffs.append(reports.handcuff!)
                     self.caseBelts.append(reports.belt!)
                     self.caseArrests.append(reports.arrest!)
                     self.caseRels.append(reports.release!)
                     self.caseWarnings.append(reports.warning!)
                    self.caseHospitals.append(reports.hospital!)
             self.caseTreatments.append(reports.treatment!)
                    self.caseSearchs.append(reports.search!)
                    
                     self.casePrisoners.append(reports.prisoner!)
                  
                    print(address)
                    print(officer)
                }
                
                self.tableView.reloadData()
            }
            
        })
    }
    // MARK: - Table view data source


    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reportsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "casesCell", for: indexPath)

            // Configure the cell...
            let reports: CaseModel
            reports = reportsList[indexPath.row]
            
        cell.textLabel?.text = ("Case #" + reports.caseNumber! + ", " + reports.type!)
        
        cell.detailTextLabel?.text = ("Officer: " + reports.officer! + " - Date: " + reports.date!)
            
            return cell
    }
    
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
        print(indexPath)
        self.selectedCaseType = caseTypes[indexPath.row]
        self.selectedCase = caseNums[indexPath.row]
        self.selectedDate = caseDates[indexPath.row]
        self.selectedOfficer = caseOfficers[indexPath.row]
        self.selectedSupervisor = caseSupers[indexPath.row]
        self.selectedOE = caseOEs[indexPath.row]
        self.selectedMedia = caseMedias[indexPath.row]
        self.selectedAddress = caseAddresses[indexPath.row]
        self.selectedZip = caseZips[indexPath.row]
        self.selectedTime = caseStarts[indexPath.row]
        self.selectedBWC = caseBWCS[indexPath.row]
        self.selectedBackup = caseBackups[indexPath.row]
        self.selectedCause = caseCauses[indexPath.row]
        self.selectedReason = caseReasons[indexPath.row]
       self.selectedSearch  = caseSearchs[indexPath.row]
        self.selectedHandcuffs = caseHandcuffs[indexPath.row]
        self.selectedBelt = caseBelts[indexPath.row]
        self.selectedArrest = caseArrests[indexPath.row]
       self.selectedReleased = caseRels[indexPath.row]
        self.selectedWarning = caseWarnings[indexPath.row]
        self.selectedhospital = caseHospitals[indexPath.row]
        self.selectedTreatment = caseTreatments[indexPath.row]
        self.selectedPrisoner = casePrisoners[indexPath.row]
        
        self.performSegue(withIdentifier: "caseDetail", sender: self)
        
    }
}

extension CaseListTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "caseDetail" {
            let officerListVC = segue.destination as! DetailCaseViewController
            officerListVC.caseNumber = self.selectedCase
            officerListVC.caseType = self.selectedCaseType
            officerListVC.selectedDate = self.selectedDate
             officerListVC.selectedOfficer = self.selectedOfficer
             officerListVC.selectedSupervisor = self.selectedSupervisor
             officerListVC.selectedOE = self.selectedOE
             officerListVC.selectedMedia = self.selectedMedia
             officerListVC.selectedAddress = self.selectedAddress
             officerListVC.selectedZip = self.selectedZip
             officerListVC.selectedTime = self.selectedTime
             officerListVC.selectedBWC = self.selectedBWC
            
            
             officerListVC.selectedBackup = self.selectedBackup
             officerListVC.selectedCause = self.selectedDate
             officerListVC.selectedReason = self.selectedReason
             officerListVC.selectedSearch = self.selectedSearch
             officerListVC.selectedHandcuffs = self.selectedHandcuffs
             officerListVC.selectedBelt = self.selectedBelt
             officerListVC.selectedArrest = self.selectedArrest
             officerListVC.selectedReleased = self.selectedReleased
             officerListVC.selectedWarning = self.selectedWarning
             officerListVC.selectedhospital = self.selectedhospital
             officerListVC.selectedTreatment = self.selectedTreatment
             officerListVC.selectedPrisoner = self.selectedPrisoner
            
            
            //studentListVC.selectedStudentIndex = self.selectedStudentIndex
        }
    }
}
