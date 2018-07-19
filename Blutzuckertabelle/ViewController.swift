//
//  ViewController.swift
//  Blutzuckertabelle
//
//  Created by Rupert Quaderer on 18.07.18.
//  Copyright © 2018 Webdevs. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var segmetControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var morning_data: [[String : String]] = []
    private var midday_data: [[String : String]] = []
    private var evening_data: [[String : String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
      
        morning_data = [
            ["blood_sugar_level" : "unter 5" , "insulin_level" : "4"],
            ["blood_sugar_level" : "5.0-8.0" , "insulin_level" : "8"],
            ["blood_sugar_level" : "8.1-12.0" , "insulin_level" : "10"],
            ["blood_sugar_level" : "12.1-15.0" , "insulin_level" : "12"],
            ["blood_sugar_level" : "15.1-20" , "insulin_level" : "14"],
            ["blood_sugar_level" : "über 20" , "insulin_level" : "16"]
        ]
        midday_data = [
            ["blood_sugar_level" : "unter 5" , "insulin_level" : "8"],
            ["blood_sugar_level" : "5.0-8.0" , "insulin_level" : "12"],
            ["blood_sugar_level" : "8.1-12.0" , "insulin_level" : "14"],
            ["blood_sugar_level" : "12.1-15.0" , "insulin_level" : "16"],
            ["blood_sugar_level" : "15.1-20" , "insulin_level" : "18"],
            ["blood_sugar_level" : "über 20" , "insulin_level" : "20"]
        ]
        evening_data = [
            ["blood_sugar_level" : "unter 5" , "insulin_level" : "8"],
            ["blood_sugar_level" : "5.0-8.0" , "insulin_level" : "10"],
            ["blood_sugar_level" : "8.1-12.0" , "insulin_level" : "12"],
            ["blood_sugar_level" : "12.1-15.0" , "insulin_level" : "14"],
            ["blood_sugar_level" : "15.1-20" , "insulin_level" : "16"],
            ["blood_sugar_level" : "über 20" , "insulin_level" : "18"]
        ]
        
    }
    
    let sections = ["Morgens", "Mittags", "Abends"]
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return morning_data.count
        case 1:
            return midday_data.count
        case 2:
            return evening_data.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = morning_data[indexPath.row]["blood_sugar_level"]
            cell.detailTextLabel?.text = morning_data[indexPath.row]["insulin_level"]
            break
        case 1:
            cell.textLabel?.text = midday_data[indexPath.row]["blood_sugar_level"]
            cell.detailTextLabel?.text = midday_data[indexPath.row]["insulin_level"]
            break
        case 2:
            cell.textLabel?.text = evening_data[indexPath.row]["blood_sugar_level"]
            cell.detailTextLabel?.text = evening_data[indexPath.row]["insulin_level"]
            break
        default:
            break
    }
    
    // Return the configured cell
    return cell
    }
}
