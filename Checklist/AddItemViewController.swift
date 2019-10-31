//
//  AddItemViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit
protocol AddItemViewControllerDelegate: class {
    func addItemControllerDidCancel(_ controller: AddItemViewController)
    func addItemController(_ controller: AddItemViewController,didFinishAdding item: ChecklistItem)
    func addItemController(_ controller: AddItemViewController,didFinishEditing item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegte:AddItemViewControllerDelegate?
    

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var checklistItem:ChecklistItem?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        doneBarButton.isEnabled = false
        if let item = checklistItem {
            title = "Edit Item"
            textField.text = item.name
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    
    @IBAction func cancel() {
//        dismiss(animated: false, completion: nil)
        delegte?.addItemControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = checklistItem {
            item.name = textField.text!
            delegte?.addItemController(self, didFinishEditing: item)
        }
        else {
            let item = ChecklistItem()
            item.name = textField.text!
            item.checked = false
            delegte?.addItemController(self, didFinishAdding: item)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        print("string = \(string)")
        print("oldText = \(oldText)")
        print("newText = \(newText)")
        doneBarButton.isEnabled = newText.length > 0
        return true
    }
 
}
