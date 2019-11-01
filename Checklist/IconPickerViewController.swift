//
//  IconPickerViewController.swift
//  Checklist
//
//  Created by liufeismart on 2019/11/1.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPick(named name: String)
}

class IconPickerViewController: UITableViewController {

    let icons = ["No Icon", "1", "2", "3"]
    weak var delegate:IconPickerViewControllerDelegate?
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Icon", for: indexPath)
        cell.imageView?.image = UIImage(named: icons[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.iconPick(named: icons[indexPath.row])
    }
}
