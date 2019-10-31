//
//  ChecklistItem.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import Foundation
class ChecklistItem: NSObject, NSCoding {
    var name = ""
    var checked = false
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        checked = aDecoder.decodeBool(forKey: "checked")
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(checked, forKey: "checked")
    }
    
   
    
}
