//
//  DataModel.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import Foundation
class DataModel: NSObject {
    
    

    public func loadChecklistItems() -> [Checklist] {
        let path = dataFilePath()
        if let data = try?Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            var lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            return lists
        }
        return [Checklist]()
    }
    
    public func saveChecklistItems(for lists:[Checklist]) {
        let path = dataFilePath()
        let data = NSMutableData()
        var archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(to: path, atomically: true)
    }
    
    func dataFilePath() -> URL {
        let paths:[URL] = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var path = paths[0]
        path = path.appendingPathComponent("Checklists.list")
        return path
    }
}
