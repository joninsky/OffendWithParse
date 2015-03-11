//
//  SecondaryViewController.swift
//  Offend
//
//  Created by Jon Vogel on 3/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit


class SecondaryViewController: UIViewController, UITextFieldDelegate {
  
  
  @IBOutlet weak var txtInputField: UITextField!
  
  @IBOutlet weak var swtchRacist: UISwitch!
  
  @IBOutlet weak var swtchSexist: UISwitch!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.txtInputField.delegate = self
  
  }
  
  
  @IBAction func addWordAction(sender: AnyObject) {
    
    self.txtInputField.resignFirstResponder()
    
    var wordToAdd = PFObject(className: "Words")
    wordToAdd["word"] = self.txtInputField.text
    wordToAdd["isRacist"] = self.swtchRacist.on
    wordToAdd["isSexist"] = self.swtchSexist.on
    wordToAdd.saveInBackgroundWithBlock { (didSave, error) -> Void in
      if didSave {
        println("Save Success")
      }else{
        println("Save Fail")
      }
      
      
    }
  }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.txtInputField.resignFirstResponder()
    return true
    
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    self.txtInputField.resignFirstResponder()
  }
  
  
}