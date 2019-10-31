//
//  ViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items:[ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        let label = cell.viewWithTag(1001) as! UILabel
        if indexPath.row <= items.count-1 {
            var checklistItem = items[indexPath.row]
            label.text = checklistItem.name
            cell.accessoryType = checklistItem.checked ? .checkmark : .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            }
            else {
                cell.accessoryType = .checkmark
            }
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
        let newRowIndex = items.count
        items.append(item)
        var indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        dismiss(animated: false, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"  {
            let navigationcontroller = segue.destination as! UINavigationController
            let controller = navigationcontroller.topViewController as! AddItemViewController
            controller.delegte = self
        }
    }

}

