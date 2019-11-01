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
    var lists: [ChecklistItem] = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        lists = aDecoder.decodeObject(forKey: "lists") as! [ChecklistItem]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(lists, forKey: "lists")
    }
}
