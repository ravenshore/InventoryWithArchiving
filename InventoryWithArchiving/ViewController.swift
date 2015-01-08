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


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
        loadInventory()
        
        
        firstNameText.delegate = self
        lastNameText.delegate = self
        ageText.delegate = self
        emailText.delegate = self
        phoneText.delegate = self
        
        firstNameText.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName : UIColor.orangeColor()])
        lastNameText.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName : UIColor.orangeColor()])
        ageText.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSForegroundColorAttributeName : UIColor.orangeColor()])
        emailText.attributedPlaceholder = NSAttributedString(string: "Valid Email", attributes: [NSForegroundColorAttributeName : UIColor.orangeColor()])
        phoneText.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSForegroundColorAttributeName : UIColor.orangeColor()])
        firstNameText.clearsOnBeginEditing = true
        lastNameText.clearsOnBeginEditing = true
        ageText.clearsOnBeginEditing = true
        emailText.clearsOnBeginEditing = true
        phoneText.clearsOnBeginEditing = true
        firstNameText.clearsOnInsertion = true
        
        
        
        
        
        
        //get the documents folder
        
        println("Documents Directory: \(documentsDirectory())")
        // Add a tap gesture to the imageview
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        imageView.addGestureRecognizer(tapGesture)
        imageView.userInteractionEnabled = true
        
        
        
    }

    
    
    
    // Saving Action
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        
        
       
        
     
        if let newContact = addNewItem() {
           
            newItem = newContact
            saveItemToDisk(newItem, path: itemSavePath)
            
            // add item to the Inventory
            addToInventory()
            
            // save item to the Inventory
            saveInventory()
        }
    
        
    }
  

}

