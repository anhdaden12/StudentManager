//
//  TableViewController.swift
//  Student_manager
//
//  Created by Ngoc on 6/21/19.
//  Copyright © 2019 Ngoc. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var data: [Student] = []
  

    @IBOutlet weak var noContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        noContentView.frame = view.bounds
        disPlaynodata(tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchObject()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        disPlaynodata(tableView)
        tableView.reloadData()
    }
    
    
    func fetchObject(){
        if let data = (try? AppDelegate.context.fetch(Student.fetchRequest()) as [Student]) {
            self.data = data
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.stClass.text = data[indexPath.row].classes
        cell.stImage.image = data[indexPath.row].image
        cell.stName.text = data[indexPath.row].name
        cell.stPhone.text = String(data[indexPath.row].phone)
        cell.viewImage.layer.masksToBounds = true
        cell.viewImage.layer.cornerRadius = cell.viewImage.bounds.width / 2
        // Configure the cell...

        return cell
    }
    
  
    
    fileprivate func disPlaynodata(_ tableView: UITableView) {
        if data.isEmpty {
            tableView.tableFooterView = noContentView
            tableView.isScrollEnabled = false
           
        }else {
            noContentView.isHidden = true
            tableView.tableFooterView = UIView()
           
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.context.delete(data[indexPath.row])
            AppDelegate.saveContext()
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            disPlaynodata(tableView)
            tableView.reloadData()
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing == true {
            return false
        }else{
            return true
        }
    }
    
    
    @IBAction func onClickEditButton(_ sender: Any) {
        isEditing = !isEditing
    }
    
    
    @IBAction func onClickDeleteButton(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            // 1
            var items = [Student]()
            for indexPath in selectedRows  {
                items.append(data[indexPath.row])
                AppDelegate.context.delete(items[indexPath.row])
                AppDelegate.saveContext()
            }
            // 2
            for item in items {
                if let index = data.index(of: item) {
                    data.remove(at: index)
                    
                }
            }
            
            // 3
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
           disPlaynodata(tableView)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc =  segue.destination as! ViewController
        if let index = tableView.indexPathForSelectedRow {
            vc.detailStudent = data[index.row]
            vc.indexPath = index
            
        }
    }
  
}
