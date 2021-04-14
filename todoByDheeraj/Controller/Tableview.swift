//
//  ViewController.swift
//  todoByDheeraj
//
//  Created by Unthinkable-mac-0040 on 13/04/21.
//

import UIKit

class Tableview: UITableViewController {
   var itemArray=["Buy Vegetables","goto gym"]
    let defaults=UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let Array=defaults.array(forKey: "ArrayList") as? [String]{
            itemArray=Array
        }
        else {
            print("Array has nothing")
        }
    }

  //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
    }

    //MARK- TableView delegate
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //Change the selected background view of the cell.
            tableView.deselectRow(at: indexPath, animated: true)
        }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
     if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        return indexPath
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        var globalTextField=UITextField()
        let alert=UIAlertController(title: "Add todo Item", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "ADD", style: .default) { (action) in
            print("Success")
            self.itemArray.append(globalTextField.text!)
            self.defaults.set(self.itemArray, forKey: "ArrayList")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Type to Add New Item"
            globalTextField=alertTextField
        }
    }
}

