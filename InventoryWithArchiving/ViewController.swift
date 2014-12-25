//
//  ViewController.swift
//  InventoryWithArchiving
//
//  Created by Razvigor Andreev on 12/21/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//

import UIKit



// Get the documents Directory

func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
    return documentsFolderPath
}
// Get path for a file in the directory

func fileInDocumentsDirectory(filename: String) -> String {
    return documentsDirectory().stringByAppendingPathComponent(filename)
}

let itemSavePath = fileInDocumentsDirectory("item.plist")
var placeHolderString: String! = "Fill out the information"


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // declare entry points
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var firstNameText: UITextField!
    @IBOutlet var lastNameText: UITextField!
    @IBOutlet var ageText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var phoneText: UITextField!
    @IBOutlet var saveStatusText: UITextField!
    
    // declare global vars
    var newItem: Item!
    var existingItem: Item!
    var inventory: Inventory!
    var inventoryPath = fileInDocumentsDirectory("inventory.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add a tap gesture to the imageview
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        imageView.addGestureRecognizer(tapGesture)
        imageView.userInteractionEnabled = true
        
        
        
    }

    
    
    
    // Saving Action
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        //        saveInventory()
     
        if let newContact = addNewItem() {
           
            newItem = newContact
            saveItemToDisk(newItem, path: itemSavePath)
        }
    
        
    }
  

}

