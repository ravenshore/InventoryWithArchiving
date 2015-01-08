//
//  functions.swift
//  InventoryWithArchiving
//
//  Created by Razvigor Andreev on 12/21/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//
import UIKit

extension ViewController {
    
    
    
  
    // Tap Gesture Handle
    
    func handleTapGesture(tapGesture: UITapGestureRecognizer) {
        // open image picker
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //        imagePicker.
        presentViewController(imagePicker, animated: true, completion: nil)
        println("tap detected")
    }
    
    
    
    
    // Image Picker Controller
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as UIImage? { // use dictionary to look up image
            
            imageView.image = image
        }
        
        // dismiss
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
   
    
    
    // Save Image
    
    func saveImage(image: UIImage, path: String) -> Bool {
        
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        // png UIImagePNG...
        let result = jpgImageData.writeToFile(path, atomically: true)
        return result
    }
    
    
    
    
    // Load Image from path
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            println("Missing image at path: \(path)")
        }
        
        return image
    }
    
    
    
    
    // Save text
    
    func saveText(text: String, path: String) -> Bool {
        var error: NSError? = nil
        let status = text.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        if !status { //status == false {
            println("Error saving file at path: \(path) with error: \(error?.localizedDescription)")
        }
        return status
    }
    
    
    
    
    
    // Load text
    
    func loadTextFromPath(path: String) -> String? {
        var error: NSError? = nil
        let text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
        if text == nil {
            println("Error loading text from path: \(path) error: \(error?.localizedDescription)")
        }
        return text
    }

    
    
    
    // Load Inventory
    
    func loadInventory() {
        // Try to load inventory
        if let inventory = loadInventory(fromPath: inventoryPath) {
            self.inventory = inventory
            println("Inventory loaded: \(self.inventory)")
        } else {
            // Initialize
            self.inventory = Inventory()
            println("Inventory created")
        }
    }
    
    
    // Load Inventory from Path
    
    func loadInventory(fromPath path: String) -> Inventory? {
        var result: Inventory? = nil
        result = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as Inventory?
        return result
    }
    
    
    
    
    
    // Save Inventory
    
    func saveInventory() {
        var success = false
        println("Inventory: \(inventory), at Invenotry Path: \(inventoryPath)")
        success = saveInventory(inventory, path:inventoryPath)
        if success {
            println("Inventory saved successfully to path: \(inventoryPath)")
        } else {
            println("Inventory failed to save to path: \(inventoryPath)")
        }
    }
    
    
    
    
    
    
    
    // Save Inventory at Path 
    
    func saveInventory(inventory: Inventory, path: String) -> Bool {
        var success = false
        
        success = NSKeyedArchiver.archiveRootObject(inventory, toFile: path)
        
        // save images
        
        if success {
            for item in inventory.itemArray {
                if let image = item.image {
                    
                    let imagePath = fileInDocumentsDirectory(item.imageName)
                    
                    saveImage(image, path: imagePath)
                    
                    println("Save item image: \(imagePath)")
                    
                }
            }
            
        }
        
        return success
    }
    
    
    
    // List Current Item
    
    
    func addNewItem()-> Item? {
        newItem = nil
        
        println("\(firstNameText.text),\(lastNameText.text),\(ageText.text),\(phoneText.text), \(emailText.text)")
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
       
        
        
            if !firstNameText.text.isEmpty {
                if !lastNameText.text.isEmpty {
                    if let ageNumber = numberFormatter.numberFromString(ageText.text)?.integerValue {
                        if !emailText.text.isEmpty {
                            
                            println("\(validateEmail(emailText.text))")
                            if validateEmail(emailText.text) == true {
                                if !phoneText.text.isEmpty {
                            
            
                            newItem = Item (firstName: firstNameText.text, lastName: lastNameText.text, age: ageNumber, email: emailText.text, phoneNumber: phoneText.text, imageName: "\(firstNameText.text).jpg")
                            
                            println("contact Saved")
                            placeHolderString = "Contact Saved"
                            changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.purpleColor())
                            
                            
                            if let savedImage: UIImage = imageView.image {
                                
                                let imageSavePath = fileInDocumentsDirectory("\(firstNameText.text).jpg")
                                saveImage( savedImage, path: imageSavePath )
                                
                                }
                        
                            
                        } else {
                            
                            println("missing phone Number")
                            placeHolderString = "missing Phone Number"
                            changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.redColor())
                            }
                                
                            } else {
                                
                            println("check email")
                            placeHolderString = "Please insert a valid email"
                            changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.redColor())
                                
                        }
                        
                        } else {
                        
                        println("missing email")
                        placeHolderString = "missing email"
                        changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.redColor())
                        
                    }
                        
                    } else  {
                        
                        println("missing age")
                        placeHolderString = "missing age"
                        changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.redColor())
                    }
                    
                    } else {
                    
                    println("missing Last Name")
                    placeHolderString = "missing Last Name"
                    changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.redColor())
                    
            }
            
            } else {
                    println("missing first Name")
                    placeHolderString = "missing First Name"
                    changeStatus(UIColor.whiteColor(), backgroundColor: UIColor.redColor())
            }
            
        
        return newItem
        
    }
    
    
    
    func addToInventory() {
    
    
        
        if let newItemChecked = addNewItem() {
            
    println("item: \(newItemChecked)")
    inventory.itemArray.append(newItemChecked)
            
        }
     
    }
    
    
    func saveItemToDisk(item: Item, path: String) -> Bool {
        var success = false
        
        success = NSKeyedArchiver.archiveRootObject(item, toFile: path)
        
        return success
        
    }
    
    
    func changeStatus(color: UIColor, backgroundColor: UIColor) {
        
        
        let placeholder = NSAttributedString(string: placeHolderString, attributes: [NSForegroundColorAttributeName : color])
        
        saveStatusText.attributedPlaceholder = placeholder
        saveStatusText.backgroundColor = backgroundColor
        
    }
    
    
    
    
    // Validate Email
    
    func validateEmail(email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = email.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
        
    }
    
    
    
    // Close Keyboard on Return
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
}
