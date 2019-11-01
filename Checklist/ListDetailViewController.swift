//
//  ListDetailViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/11/1.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController,didFinishAdding item: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController,didFinishEditing item: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate:ListDetailViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    weak var checklist: Checklist?
    
    override func viewDidLoad() {
        if let item = checklist {
            title = item.name
        }
        else {
            title = "Add Checklist"
        }
    }
    
    @IBAction func done() {
        if let item = checklist {
            item.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditing: item)
        }
        else {
            var name = textField.text!
            var item = Checklist(name:name)
            delegate?.listDetailViewController(self, didFinishAdding: item)
            
        }
    }
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with:string) as NSString
        doneBarButton.isEnabled = newText.length>0
        return true
    }
    
}
