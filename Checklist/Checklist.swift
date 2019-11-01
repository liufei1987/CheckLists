//
//  Checklist.swift
//  Checklist
//
//  Created by liufeismart on 2019/11/1.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import Foundation
class Checklist: NSObject, NSCoding {
    var name = ""
    var iconName:String = "No Icon"
    var lists: [ChecklistItem] = [ChecklistItem]()
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        lists = aDecoder.decodeObject(forKey: "lists") as! [ChecklistItem]
        iconName = aDecoder.decodeObject(forKey: "iconName") as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(lists, forKey: "lists")
        aCoder.encode(iconName, forKey: "iconName")
    }
    
    
    func countUnCheckedItems() -> Int {
        var count:Int = 0
        for item in lists where !item.checked {
            count += 1
        }
        return count
    }
}
