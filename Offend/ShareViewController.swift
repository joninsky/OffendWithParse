//
//  ShareViewController.swift
//  Offend
//
//  Created by Jon Vogel on 3/13/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
  
  @IBOutlet weak var txtPhraseToShare: UILabel!
  @IBOutlet weak var shareButton: UIButton!
  var thePhrase: String!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    txtPhraseToShare.text = thePhrase
    
  }
  
  
  @IBAction func shareAction(sender: AnyObject) {
    
    if GlobalStuff.sharedInstance.userObject == NSNull() {
      let alertController = UIAlertController(title: "Name", message: "We need a user name from you in order to share your offensive phrase", preferredStyle: UIAlertControllerStyle.Alert)
      
      //Dismiss Alert action
      let alertActionDismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
      })
      //Create action
      let alertActionCreate = UIAlertAction(title: "Create", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
        //Create a UIText Field out of the first object int he array of text fields
        let field = alertController.textFields?.first as UITextField
        //Use Offensive engine singleton to check if user exists
        GlobalStuff.sharedInstance.checkIfUserExists(field.text, completion: { (decision) -> Void in
          if decision == false {
            GlobalStuff.sharedInstance.makeUser(field.text)
            
            let myNewPhrase = PFObject(className: "SavedPhrases")
            myNewPhrase.setObject(self.txtPhraseToShare.text, forKey: "phrase")
            myNewPhrase.setObject(GlobalStuff.sharedInstance.userObject!, forKey: "user")
            myNewPhrase.saveInBackgroundWithBlock({ (didSave, error) -> Void in

            })
            
            
          }else{
            println("User Exists!")
          }
        })
      })
      
      //Add the actions and present the Controller
      alertController.addAction(alertActionDismiss)
      alertController.addAction(alertActionCreate)
      alertController.addTextFieldWithConfigurationHandler({ (theField) -> Void in
        theField.placeholder = "New Name"
        
      })
      presentViewController(alertController, animated: true, completion: nil)
      
    }else{
      let newPhrase = PFObject(className: "SavedPhrases")
      newPhrase["phrase"] = self.txtPhraseToShare.text
      newPhrase["user"] = GlobalStuff.sharedInstance.userName
      newPhrase.saveInBackgroundWithBlock({ (didSave, error) -> Void in
        if didSave {
          println("User Created!")
        }else{
          println("User Not Created")
        }
      })
      
    }
  }
  
  
  
  
}