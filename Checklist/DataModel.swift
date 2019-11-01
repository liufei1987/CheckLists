//
//  DataModel.swift
//  Checklist
//
//  Created by liufeismart on 2019/10/31.
//  Copyright © 2019 liufeismart. All rights reserved.
//

import Foundation
class DataModel: NSObject {
    
    var lists:[Checklist] = [Checklist]()
    
    var indexOfSelectedChecklist:Int {
        get {
            return UserDefaults.standard.integer(forKey: "Checklists")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Checklists")
        }
    }
    
    override init() {
        super.init()
        loadChecklistItems()
        registerUserDefaults()
        handleFirstTime()
    }

    public func loadChecklistItems() {
        let path = dataFilePath()
        if let data = try?Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
        }
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
    
    func registerUserDefaults() {
        let dict = ["ChecklistIndex":-1, "FirstTime": true] as [String : Any]
        UserDefaults.standard.register(defaults: dict)
    }
    
    func handleFirstTime() {
        let firstTime = UserDefaults.standard.bool(forKey: "FirstTime")
        if firstTime {
            UserDefaults.standard.set(false, forKey: "FirstTime")
            UserDefaults.standard.synchronize()
            var checklist = Checklist(name: "Exam")
            indexOfSelectedChecklist = 0
            lists.append(checklist)
        }
    }
    
    func sortChecklists() {
        lists.sort(by: {
            checklist1, checklist2 in
            return checklist1.name.localizedStandardCompare(checklist2.name) ==
                ComparisonResult.orderedAscending
        })
    }
}
