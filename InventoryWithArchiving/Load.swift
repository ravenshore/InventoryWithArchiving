//
//  Load.swift
//  InventoryWithArchiving
//
//  Created by Razvigor Andreev on 12/24/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//

import UIKit

class Load: UIViewController {

    
    @IBOutlet var imageViewL: UIImageView!
    @IBOutlet var firstNameTextL: UITextField!
    @IBOutlet var lastNameTextL: UITextField!
    @IBOutlet var ageTextL: UITextField!
    @IBOutlet var emailTextL: UITextField!
    @IBOutlet var phoneTextL: UITextField!
    @IBOutlet var loadStatusText: UITextField!
    @IBOutlet var indexLabelView: UIView!
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var indexLabel: UILabel!
    
    
    
    var index = 0
    var item: Item!
    var inventory: Inventory!
    var inventoryPath = fileInDocumentsDirectory("inventory.plist")
    
    
    // place holder
    var placeHolderText: String!
    
    //we need to use the load Image from Path function here....
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            println("Missing image at path: \(path)")
        }
        
        return image
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("\(index)")
        
        indexLabelView.layer.cornerRadius = 15
        indexLabelView.clipsToBounds = true
        indexLabel.text = "1"
        
        
        loadStatusText.backgroundColor = UIColor.purpleColor()
      
        if let checkInventory = loadInventory(fromPath: inventoryPath) {
        
        isData()
        loadInventory()
            loadItem(inventory.itemArray[index])
        changePlaceHolderText()
        } else {
            noData()
        }
        
        
        
 
        
    }
    
    

    @IBAction func previousPressed(sender: AnyObject) {
        
        if index == 0 {
            index = inventory.itemArray.count - 1
            
        } else {
        index--
        }
        println("index: \(index)")
        indexLabel.text = "\(index + 1)"
        loadItem(inventory.itemArray[index])
        changePlaceHolderText()
        
    }
   
    @IBAction func nextPressed(sender: AnyObject) {
        
        if index >= inventory.itemArray.count - 1 {
            index = 0
        } else {
            index++
        }
        println("index: \(index)")
        indexLabel.text = "\(index + 1)"
        loadItem(inventory.itemArray[index])
        
        changePlaceHolderText()
        
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

    func loadItem (itemToLoad: Item) {
    
        firstNameTextL.text = itemToLoad.firstName
        lastNameTextL.text = itemToLoad.lastName
        ageTextL.text = "\(itemToLoad.age)"
        emailTextL.text = itemToLoad.email
        let imageLoadPath = fileInDocumentsDirectory(itemToLoad.imageName)
        
            
            
            if let loadedImage: UIImage = loadImageFromPath(imageLoadPath) {
                
                imageViewL.image = loadedImage
                println("Loaded Image at: \(imageLoadPath)")
                
            } else {
                
                println("No image found at: \(imageLoadPath)") //we could load a stock "missing image" image here...
            }

        
        
        
    
    }
    
    func changePlaceHolderText () {
        
        let itemToLoad = (inventory.itemArray[index])
        placeHolderText = "Loaded Saved Contact: \(itemToLoad.firstName)"
        loadStatusText.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        
    }
    
    func isData() {
        
        println("Data loaded")
        previousButton.hidden = false
        nextButton.hidden = false
        indexLabel.hidden = false
        indexLabelView.hidden = false
        
    }
    
    func noData() {
        
        println("No Data")
        previousButton.hidden = true
        nextButton.hidden = true
        indexLabel.hidden = true
        indexLabelView.hidden = true
        imageViewL.image = UIImage(named: "nothing_to_see_here.jpg")
        
    }
   
}
