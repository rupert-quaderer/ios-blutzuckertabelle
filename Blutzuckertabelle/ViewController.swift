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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
   /* let morningArray =
        ["unter 5" : "4",
         "5.0-8.0" : "8",
         "8.1-12.0" : "10",
         "12.1-15.0" : "12",
         "15.1-20" : "14",
         "über 20" : "16"
    ]*/
    
    let sections = ["Morgen", "Mittag", "Abend"]
    let tableMorning = ["unter 5", "5.0-8.0", "8.1-12.0","12.1-15.0","15.1-20","über 20"]
    let morningIndex = ["4", "8", "10","12","14","16"]
    let tableLunch = ["unter 5", "5.0-8.0", "8.1-12.0","12.1-15.0","15.1-20","über 20"]
    let lunchIndex = ["8", "12", "14","16","18","20"]
    let tableEvening = ["unter 5", "5.0-8.0", "8.1-12.0","12.1-15.0","15.1-20","über 20"]
    let eveningIndex = ["8", "10", "12","14","16","18"]
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tableMorning.count
        case 1:
            return tableLunch.count
        case 2:
            return tableEvening.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        // Depending on the section, fill the textLabel with the relevant text
        switch indexPath.section {
        case 0:
            // Fruit Section
            cell.textLabel?.text = tableMorning[indexPath.row]
            cell.detailTextLabel?.text = morningIndex[indexPath.row]
            break
        case 1:
            // Vegetable Section
            cell.textLabel?.text = tableLunch[indexPath.row]
            cell.detailTextLabel?.text = lunchIndex[indexPath.row]
            break
        case 2:
            // Evening Section
            cell.textLabel?.text = tableEvening[indexPath.row]
            cell.detailTextLabel?.text = eveningIndex[indexPath.row]
            break
        default:
            break
    }
    
    // Return the configured cell
    return cell
    }
}
