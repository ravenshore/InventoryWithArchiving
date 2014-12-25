//
//  Inventory.swift
//  InventoryWithArchiving
//
//  Created by Razvigor Andreev on 12/21/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//

import UIKit

class Inventory: NSObject, NSCoding {
    
    // list of items
    var itemArray: [Item]
    
    // last viewed item
    var lastViewedIndex: Int?
    
    let kItemArrayKey = "itemArray"
    let kLastViewedIndex = "lastViewedIndex"
    
    override init() {
        itemArray = [Item]()
        lastViewedIndex = nil
        
        // Lastly call super.init()
        super.init()
    }
    
    override var description: String {
        return "items: \(itemArray), lastViewedIndex: \(lastViewedIndex)"
    }
    
    required init(coder decoder: NSCoder) {
        itemArray = decoder.decodeObjectForKey(kItemArrayKey) as [Item]
        lastViewedIndex = decoder.decodeObjectForKey(kLastViewedIndex) as Int?
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(itemArray, forKey: kItemArrayKey)
        aCoder.encodeObject(lastViewedIndex, forKey: kLastViewedIndex)
    }
    
}
