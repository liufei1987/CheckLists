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

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    
    weak var delegate:ListDetailViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    weak var checklist: Checklist?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        if let item = checklist {
            title = item.name
            doneBarButton.isEnabled = true
            textField.text = item.name
            if item.iconName != "No Icon" {
                imageView.image = UIImage(named:item.iconName)
            }
        }
        else {
            title = "Add Checklist"
            doneBarButton.isEnabled = false
        }
        textField.becomeFirstResponder()
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
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 {
            return nil
        }
        else {
            return indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performSegue(withIdentifier: "IconPick", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IconPick" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
    
    func iconPick(named name: String) {
//        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))
//        let imageView = cell?.viewWithTag(1001) as! UIImageView
        checklist?.iconName = name
        imageView.image = UIImage(named: name)
        let _ = navigationController?.popViewController(animated: true)
    }
}
