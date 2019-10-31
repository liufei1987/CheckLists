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
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegte:AddItemViewControllerDelegate?
    

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        doneBarButton.isEnabled = false
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    
    @IBAction func cancel() {
//        dismiss(animated: false, completion: nil)
        delegte?.addItemControllerDidCancel(self)
    }
    
    @IBAction func done() {
        var checklistItem:ChecklistItem = ChecklistItem()
        checklistItem.name = textField.text!
        checklistItem.checked = false
        delegte?.addItemController(self, didFinishAdding: checklistItem)
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
