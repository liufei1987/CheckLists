//
//  AllListsViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    var dataModel: DataModel
    var lists:[Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        dataModel = DataModel()
        lists = dataModel.loadChecklistItems()
        var checklist = Checklist(name: "birthday")
        lists.append(checklist)
        super.init(coder: aDecoder)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(tableView)
        cell.textLabel?.text = lists[indexPath.row].name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        var checklist = lists[indexPath.row]
        performSegue(withIdentifier: "EditChecklist", sender: checklist)
    }
    
    
    func makeCell(_ tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell1"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        }
        else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
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
        let newIndex = lists.count
        lists.append(item)
        var indexPath = IndexPath(row: newIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        dismiss(animated: true, completion: nil)
        
    }
    func listDetailViewController(_ controller: ListDetailViewController,didFinishEditing item: Checklist) {
        if let index = lists.firstIndex(of: item) {
            lists[index] = item
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell!.textLabel?.text = item.name
        }
        dismiss(animated: true, completion: nil)
    }
}
