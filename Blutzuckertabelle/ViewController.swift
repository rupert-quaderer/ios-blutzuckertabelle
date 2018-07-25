//
//  ViewController.swift
//  Blutzuckertabelle
//
//  Created by Rupert Quaderer on 18.07.18.
//  Copyright © 2018 Webdevs. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate,CBPeripheralDelegate {
    
    @IBOutlet weak var segmetControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    private var morning_data: [[String : String]] = []
    private var midday_data: [[String : String]] = []
    private var evening_data: [[String : String]] = []
    
    var bluetoothManager:CBCentralManager!
    var glucosePeripheral:CBPeripheral!
    
    let glucoseCBUUID = CBUUID(string: "0x1808")
    let defaults = UserDefaults.standard
    
    //date time
    let date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //save state
        self.restorationIdentifier = "HomeVC"
        
        tableView.delegate = self
        tableView.dataSource = self
      
        viewTitleLabel.text = segmetControl.titleForSegment(at: segmetControl.selectedSegmentIndex)
     
        
        bluetoothManager = CBCentralManager(delegate: self, queue: nil)
        let hour = Calendar.current.component(.hour, from: date)
        
        switch hour {
            case 6..<12 :
                 segmetControl.selectedSegmentIndex = 0
            case 12..<14 :
                segmetControl.selectedSegmentIndex = 1
            case 14..<24 :
                segmetControl.selectedSegmentIndex = 2
            default:
                segmetControl.selectedSegmentIndex = 0
        }
        
        viewTitleLabel.text = segmetControl.titleForSegment(at: segmetControl.selectedSegmentIndex)
        
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
    
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        viewTitleLabel.text = segmetControl.titleForSegment(at: segmetControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch segmetControl.selectedSegmentIndex {
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
        
        switch segmetControl.selectedSegmentIndex {
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
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaults.set(indexPath,forKey: "selectedRow")

    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices:[glucoseCBUUID])
            //print("BT an")
            
        } else {
            //print("Bluetooth not available.")
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        glucosePeripheral = peripheral
        bluetoothManager.stopScan()
        bluetoothManager.connect(glucosePeripheral)
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //print("verbundne")
        //print(peripheral)
    }
    
    
}

/*extension ViewController{
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(self.tableView,forKey: "HomeVC")
        //print("tableView encode")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        coder.decodeObject(forKey: "HomeVC")
        //print("tableView decode")
    }
    override func applicationFinishedRestoringState() {
        //print("tableView finished restoring")
        self.tableView.reloadData()
    }
}*/


