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
        
        
        if let loadedContact = NSKeyedUnarchiver.unarchiveObjectWithFile(itemSavePath) as Item? {
            
            // add to UI
            firstNameTextL.text = loadedContact.firstName
            lastNameTextL.text = loadedContact.lastName
            ageTextL.text = String(loadedContact.age)
            emailTextL.text = loadedContact.email
            phoneTextL.text = loadedContact.phoneNumber
            
            
            let imageLoadPath = fileInDocumentsDirectory("\(loadedContact.firstName).jpg")
            if let loadedImage: UIImage = loadImageFromPath(imageLoadPath) {
                
                imageViewL.image = loadedImage
                
            } else {
                
                // we could load a stock "missing image" image here...
            }
            
            
//            if let loadedImage: UIImage = load
            
           

            
            placeHolderText = "Loaded Saved Contact: \(loadedContact.firstName)"

            loadStatusText.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
            loadStatusText.backgroundColor = UIColor.purpleColor()
            
            
            
        }

        
        
        
        
    }

   
    

   
}
