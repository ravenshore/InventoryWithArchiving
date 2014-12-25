//
//  Item.swift
//  InventoryWithArchiving
//
//  Created by Razvigor Andreev on 12/21/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    // Properties
    var firstName: String
    var lastName: String
    var age: Int
    var email: String
    var phoneNumber: String
    var imageName: String
    
    var image: UIImage?
    
    let kFirstNameKey = "firstName"
    let kLastNameKey = "lastName"
    let kAgeKey = "age"
    let kEmailKey = "email"
    let kPhoneNumberKey = "phoneNumber"
    let kImageNameKey = "imageName"
    
    // initializers
    
    init(firstName: String, lastName: String,age: Int, email: String, phoneNumber: String, imageName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.phoneNumber = phoneNumber
        self.imageName = imageName
        
        self.image = nil
        
        // required to init super class
        super.init()
    }
    
    override var description: String {
        return "\(firstName), $\(lastName),\(age), \(email), \(phoneNumber) image name: \(imageName)"
    }
    
    // NSCoder Protocol methods
    
    required init(coder aDecoder: NSCoder) {
        
        self.firstName = aDecoder.decodeObjectForKey(kFirstNameKey) as String
        self.lastName = aDecoder.decodeObjectForKey(kLastNameKey) as String
        self.age = aDecoder.decodeObjectForKey(kAgeKey) as Int
        self.email = aDecoder.decodeObjectForKey(kEmailKey) as String
        self.phoneNumber = aDecoder.decodeObjectForKey(kPhoneNumberKey) as String
        
        self.imageName = aDecoder.decodeObjectForKey(kImageNameKey) as String
        
        self.image = nil
        
        super.init() // subclass of another super.init(coder)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(firstName, forKey: kFirstNameKey)
        aCoder.encodeObject(lastName, forKey: kLastNameKey)
        aCoder.encodeObject(age, forKey: kAgeKey)
        aCoder.encodeObject(email, forKey: kEmailKey)
        aCoder.encodeObject(phoneNumber, forKey: kPhoneNumberKey)
        aCoder.encodeObject(imageName, forKey: kImageNameKey)
        
        // don't encode images in archives, store a name to the image file on disk
    }
    
}

