//
//  AllListsViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    
    override func viewDidLoad() {
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index != -1 && index < dataModel.lists.count {
            performSegue(withIdentifier: "ShowChecklist", sender: dataModel.lists[index])
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(tableView)
        let item = dataModel.lists[indexPath.row]
        cell.textLabel?.text = item.name
        let count = item.countUnCheckedItems()
        var detailText:String
        if item.lists.count == 0 {
            detailText = "No Items"
        } else if count == 0 {
            detailText = "All Done"
        }
        else {
            detailText = "\(item.countUnCheckedItems()) Remaining"
        }
        cell.imageView?.image = UIImage(named: item.iconName)
        cell.detailTextLabel!.text = detailText
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    

    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "delete"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            dataModel.lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var checklist = dataModel.lists[indexPath.row]
        dataModel.indexOfSelectedChecklist = indexPath.row
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        var checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "EditChecklist", sender: checklist)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if(viewController === self) {
            dataModel.indexOfSelectedChecklist = -1
        }
        
    }
    
    
    func makeCell(_ tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell1"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            cell.accessoryType = .detailDisclosureButton
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
             let controller = segue.destination as! ChecklistsViewController
             controller.checklist = sender as! Checklist
        }
        else if segue.identifier == "AddChecklist" {
            let navigationcontroller = segue.destination as! UINavigationController
            let controller = navigationcontroller.topViewController as! ListDetailViewController
            controller.delegate = self
        }
        else if segue.identifier == "EditChecklist" {
            let navigationcontroller = segue.destination as! UINavigationController
            let controller = navigationcontroller.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklist = sender as! Checklist
        }
    }
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(_ controller: ListDetailViewController,didFinishAdding item: Checklist) {
        let newIndex = dataModel.lists.count
        dataModel.lists.append(item)
        dataModel.sortChecklists()
        var indexPath = IndexPath(row: newIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        dismiss(animated: true, completion: nil)
        
    }
    func listDetailViewController(_ controller: ListDetailViewController,didFinishEditing item: Checklist) {
        if let index = dataModel.lists.firstIndex(of: item) {
            dataModel.lists[index] = item
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell!.textLabel?.text = item.name
        }
        dataModel.sortChecklists()
        dismiss(animated: true, completion: nil)
    }
}
