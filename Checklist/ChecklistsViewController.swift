//
//  ViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, AddItemViewControllerDelegate {
    
    
    
//    var items:[ChecklistItem]!
    var checklist:Checklist!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        if indexPath.row <= checklist.lists.count-1 {
            var checklistItem = checklist.lists[indexPath.row]
            configureText(for: cell, with: checklistItem)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let checkedLabel = cell.viewWithTag(1002) as! UILabel
            var checklistItem = checklist.lists[indexPath.row]
            checklistItem.checked = !checklistItem.checked
            checkedLabel.text = checklistItem.checked ? "√" : ""
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
//    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        return nil
//    }

    func addItemControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: false, completion: nil)
    }
    
    func addItemController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.lists.count
        checklist.lists.append(item)
        var indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        dismiss(animated: false, completion: nil)
    }
    
    func addItemController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.lists.firstIndex(of: item) {
            checklist.lists[index] = item
            var indexPath = IndexPath(item: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: false, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"  {
            let navigationcontroller = segue.destination as! UINavigationController
            let controller = navigationcontroller.topViewController as! AddItemViewController
            controller.delegte = self
        }
        else if segue.identifier == "EditItem" {
            let navigationcontroller = segue.destination as! UINavigationController
            let controller = navigationcontroller.topViewController as! AddItemViewController
            controller.delegte = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.checklistItem = checklist.lists[indexPath.row]
            }
        }
    }
    
    func configureText(for cell:UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        let checkedLabel = cell.viewWithTag(1002) as! UILabel
        label.text = item.name
        checkedLabel.text = item.checked ? "√" : ""
    }

}

