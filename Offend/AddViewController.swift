//
//  AddViewController
//  Offend
//
//  Created by Jon Vogel on 3/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit


class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
  
  
  @IBOutlet weak var txtInputField: UITextField!
  
  @IBOutlet weak var swtchRacist: UISwitch!
  
  @IBOutlet weak var swtchSexist: UISwitch!
  
  @IBOutlet weak var txtDefinition: UITextView!
  
  @IBOutlet weak var addWordButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.txtInputField.delegate = self
    self.txtDefinition.delegate = self
    self.addWordButton.layer.borderWidth = 2.0
    self.addWordButton.layer.borderColor = UIColor.blueColor().CGColor
    self.addWordButton.layer.cornerRadius = 5
    self.txtInputField.layer.borderWidth = 2.0
    self.txtInputField.layer.borderColor = UIColor.blueColor().CGColor
    self.txtInputField.layer.cornerRadius = 5

    self.txtDefinition.layer.borderWidth = 2.0
    self.txtDefinition.layer.borderColor = UIColor.blueColor().CGColor
    self.txtDefinition.layer.cornerRadius = 5
  
    self.navigationItem.title = "Add A Word!"
  }
  
  
  @IBAction func addWordAction(sender: AnyObject) {
    
    self.txtInputField.resignFirstResponder()
    
    let alertController = UIAlertController(title: "Confirmation", message: "Are you shure you want to submit \(txtInputField.text) to the global data base?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let alertActionDismiss = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil)
    let alertActionSend = UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default) { (action) -> Void in
      
      var wordToAdd = PFObject(className: "Words")
      wordToAdd["word"] = self.txtInputField.text
      wordToAdd["isRacist"] = self.swtchRacist.on
      wordToAdd["isSexist"] = self.swtchSexist.on
      wordToAdd["definition"] = self.txtDefinition.text
      wordToAdd.saveInBackgroundWithBlock { (didSave, error) -> Void in
        if didSave {
          println("Save Success")
          self.txtInputField.text = ""
          self.txtDefinition.text = ""
        }else{
          println("Save Fail")
        }
      }
    }
    
    alertController.addAction(alertActionDismiss)
    alertController.addAction(alertActionSend)
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    if textView == self.txtDefinition{
      if self.txtDefinition.text == "Definition"{
        self.txtDefinition.text = ""
      }
    }
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    self.txtDefinition.resignFirstResponder()
  }
  
  
  //MARK: text field functions
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField == self.txtInputField {
      if self.txtInputField.text == "Word"{
        self.txtInputField.text = ""
      }
    }
  }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.txtInputField.resignFirstResponder()
    return true
    
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
  
    if self.txtInputField.isFirstResponder() == true {
      self.txtInputField.resignFirstResponder()
    }else if self.txtDefinition.isFirstResponder() == true {
      self.txtDefinition.resignFirstResponder()
    }
    
  }
  
  
}